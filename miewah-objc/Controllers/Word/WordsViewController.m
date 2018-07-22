//
//  WordsMieMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsViewController.h"
#import "ItemTableViewCell.h"
#import "NotificationBanner.h"
#import "ListLoadMoreFooterView.h"
#import "MiewahWord.h"
#import <Masonry/Masonry.h>
#import "UIContainerBuilder.h"

#import "WordListViewModel.h"
#import "UIConstants.h"

#import "UIColor+Hex.h"
#import "UITableView+AutoRefresh.h"

@interface WordsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ListLoadMoreFooterView *footer;

@property (nonatomic, strong) WordListViewModel *vm;

@end

@interface WordsViewController (loadMoreFooter)<ListLoadMoreFooterViewDelegate>
@end

@implementation WordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupBars];
    [self setupSubviews];
    [self linkSignals];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.vm.items.count <= 0) {
        [self.vm readCache];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)linkSignals {
    @weakify(self);
    
    [self.vm.loadedSuccess subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadedFailure subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.refreshControl endRefreshing];
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:nil style:BannerStyleWarning onViewController:nil];
        };
        
        runOnMainThread(_);
    }];
    
    [self.vm.readCacheCompleted subscribeCompleted:^{
        @strongify(self);
        void(^_)(void) = ^void() {
            [self.tableView reloadData];
            
            [self.tableView refresh];
            [self actionRefresh:nil];
        };
        runOnMainThread(_);
    }];
}

- (void)setupBars {
    self.navigationItem.title = @"词";
    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    self.tabBarItem.title = nil;
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

- (void)actionRefresh:(UIRefreshControl *)sender {
    [self.vm reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiewahWord *item = (MiewahWord *)self.vm.items[indexPath.row];
    NSURL *routeURL = [RouteHelper wordDetailRouteURLOfObjectId:item.objectId item:item.item pronunciation:item.pronunciation otherParams:nil];
    [JLRoutes routeURL:routeURL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    MiewahWord *word = (MiewahWord *)self.vm.items[indexPath.row];
    cell.item = word.item;
    cell.pronunciation = word.pronunciation;
    cell.meaning = word.meaning;
    cell.updateAt = [word normalFormatUpdatedAt];
    return cell;
}

- (MiewahItemType)miewahItemType {
    return MiewahItemTypeWord;
}

#pragma mark - Accessors

- (UITableView *)tableView {
    if (_tableView == nil) {
        NSArray *cellInfo = @[@{TableViewBuilderCellClassKey: [ItemTableViewCell class], TableViewBuilderCellIdentifierKey: [ItemTableViewCell reuseIdentifier]}];
        _tableView = [UIContainerBuilder tableViewWithBackgroundColor:[UIColor colorWithHexString:@"#F6F6F6"]
                                                            rowHeight:[ItemTableViewCell cellHeight]
                                                             cellInfo:cellInfo
                                                             delegate:self
                                                           dataSource:self];
        
        _tableView.showsVerticalScrollIndicator = YES;
        
        // 设置 tableview 的下拉刷新
        _tableView.refreshControl = self.refreshControl;
        
        // 设置 tableview 最下面的点击加载
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (WordListViewModel *)vm {
    if (_vm == nil) {
        _vm = [[WordListViewModel alloc] init];
    }
    return _vm;
}

- (UIRefreshControl *)refreshControl {
    if (_refreshControl == nil) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(actionRefresh:) forControlEvents:UIControlEventValueChanged];
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

@implementation WordsViewController(loadMoreFooter)

- (void)footerWillLoadMore:(ListLoadMoreFooterView *)footer {
    [self.vm loadData];
}

@end
