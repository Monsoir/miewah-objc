//
//  WordsMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharactersViewController.h"
#import "ItemTableViewCell.h"
#import "ListLoadMoreFooterView.h"
#import "CharacterListViewModel.h"
#import "UIConstants.h"
#import "NotificationBanner.h"
#import "CharacterDetailViewController.h"
#import "MiewahCharacter.h"

#import "UIColor+Hex.h"
#import "UITableView+AutoRefresh.h"

@interface CharactersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ListLoadMoreFooterView *footer;

@property (nonatomic, strong) CharacterListViewModel *vm;

@end

@interface CharactersViewController (loadMoreFooter)<ListLoadMoreFooterViewDelegate>
@end

@implementation CharactersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
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
            // 先显示缓存数据
            [self.tableView reloadData];
            
            // 再请求新数据
            [self.tableView refresh];
            [self actionRefresh:nil];
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
//    [self configureNewOneItem];
}

- (void)setupSubviews {
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    self.tableView.rowHeight = [ItemTableViewCell cellHeight];
    [self.tableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:[ItemTableViewCell reuseIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    
    // 设置 tableview 的下拉刷新
    self.tableView.refreshControl = self.refreshControl;
    
    // 设置 tableview 最下面的点击加载
    self.tableView.tableFooterView = self.footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    MiewahCharacter *character = (MiewahCharacter *)self.vm.items[indexPath.row];
    cell.item = character.item;
    cell.pronunciation = character.pronunciation;
    cell.meaning = character.meaning;
    cell.updateAt = [character normalFormatUpdatedAt];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiewahCharacter *item = (MiewahCharacter *)self.vm.items[indexPath.row];
    NSURL *routeURL = [RouteHelper characterDetailRouteURLOfObjectId:item.objectId item:item.item pronunciation:item.pronunciation];
    [JLRoutes routeURL:routeURL];
}

- (void)actionRefresh:(UIRefreshControl *)sender {
    [self.vm reloadData];
}

- (CharacterListViewModel *)vm {
    if (_vm == nil) {
        _vm = [[CharacterListViewModel alloc] init];
    }
    return _vm;
}

- (MiewahItemType)miewahItemType {
    return MiewahItemTypeCharacter;
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

@implementation CharactersViewController(loadMoreFooter)

- (void)footerWillLoadMore:(ListLoadMoreFooterView *)footer {
    [self.vm loadData];
}

@end
