//
//  MiewahListFutureViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/17.
//  Copyright © 2018 wenyongyang. All rights reserved.
//
// 此 controller 暂时在 favor list 中使用
// 将来应该用来替代所有 list, 代替 Storyboard 中的 list
//

#import "MiewahListFutureViewController.h"
#import <Masonry/Masonry.h>
#import <JLRoutes/JLRoutes.h>
#import "UITableView+AutoRefresh.h"
#import "UIColor+Hex.h"
#import "ItemTableViewCell.h"
#import "ListLoadMoreFooterView.h"
#import "MiewahAsset.h"
#import "MiewahListViewModel.h"
#import "UIConstants.h"
#import "RouteHelper.h"
#import "UIViewController+NavigationItem.h"

NSString * const MiewahListFutureViewControllerTypeKey = @"MiewahListFutureViewControllerTypeKey";

@interface MiewahListFutureViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ListLoadMoreFooterView *footer;
@property (nonatomic, strong) MiewahListViewModel *vm;

@end

@interface MiewahListFutureViewController(loadMoreFooter)<ListLoadMoreFooterViewDelegate>
@end

@implementation MiewahListFutureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSingals];
    [self.vm readFavored];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", [self class]);
#endif
}

- (void)setupNavigationBar {
    NSString *title = nil;
    switch ([[self.vm class] assetType]) {
        case MiewahItemTypeCharacter:
            title = @"收藏 - 字";
            break;
        case MiewahItemTypeWord:
            title = @"收藏 - 词";
            break;
        case MiewahItemTypeSlang:
            title = @"收藏 - 短语";
            break;
            
        default:
            break;
    }
    self.title = title;
    [self removeBackButtonItemTitle];
}

- (void)linkSingals {
    @weakify(self);
    [self.vm.readFavoredCompleted subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^() {
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        };
        
        runOnMainThread(_);
    }];
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.edges.equalTo(self.view.safeAreaLayoutGuide);
        } else {
            make.edges.equalTo(self.view.layoutGuides);
        }
    }];
}

- (void)setInitialInfo:(NSDictionary *)userInfo {
    MiewahItemType type = [[userInfo objectForKey:MiewahListFutureViewControllerTypeKey] integerValue];
    _vm = [MiewahListViewModel viewModelOfType:type];
}

- (void)actionRefresh {
    [self.vm resetFlags];
    [self.vm readFavored];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MiewahAsset *asset = self.vm.items[indexPath.row];
    NSURL *route = nil;
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    switch ([[self.vm class] assetType]) {
        case MiewahItemTypeCharacter:
            route = [RouteHelper characterDetailRouteURLOfObjectId:asset.objectId item:asset.item pronunciation:asset.pronunciation otherParams:otherParams];
            break;
        case MiewahItemTypeWord:
            route = [RouteHelper wordDetailRouteURLOfObjectId:asset.objectId item:asset.item pronunciation:asset.pronunciation otherParams:otherParams];
            break;
        case MiewahItemTypeSlang:
            route = [RouteHelper slangDetailRouteURLOfObjectId:asset.objectId item:asset.item pronunciation:asset.pronunciation otherParams:otherParams];
            break;
            
        default:
            break;
    }
    if (route == nil) return;
    
    [JLRoutes routeURL:route];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    MiewahAsset *asset = self.vm.items[indexPath.row];
    cell.item = asset.item;
    cell.pronunciation = asset.pronunciation;
    cell.meaning = asset.meaning;
    cell.updateAt = [asset normalFormatUpdatedAt];
    return cell;
}

#pragma mark - Accessors

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = [ItemTableViewCell cellHeight];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        [_tableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:[ItemTableViewCell reuseIdentifier]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refreshControl = self.refreshControl;
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (UIRefreshControl *)refreshControl {
    if (_refreshControl == nil) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(actionRefresh) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (ListLoadMoreFooterView *)footer {
    if (_footer == nil) {
        _footer = [[ListLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 50)];
        _footer.delegate = self;
    }
    return _footer;
}

@end

@implementation MiewahListFutureViewController(loadMoreFooter)

- (void)footerWillLoadMore:(ListLoadMoreFooterView *)footer {
    [self.vm readFavored];
}

@end
