//
//  SlangsViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangsViewController.h"
#import "ItemTableViewCell.h"
#import "NotificationBanner.h"
#import "ListLoadMoreFooterView.h"
#import "SlangsViewModel.h"
#import "MiewahSlang.h"
#import "SlangDetailViewController.h"

#import "UIConstants.h"

#import "UIColor+Hex.h"
#import "UINavigationBar+BottomLine.h"

@interface SlangsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ListLoadMoreFooterView *footer;

@property (nonatomic, strong) SlangsViewModel *vm;

@end

@interface SlangsViewController (loadMoreFooter)<ListLoadMoreFooterViewDelegate>
@end

@implementation SlangsViewController

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.vm.items.count == 0) {
        self.loadingIndicator.hidden = NO;
        [self.loadingIndicator startAnimating];
        [self.vm reloadData];
    }
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

- (void)linkSignals {
    @weakify(self);
    
    [self.vm.noMoreDataSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            self.footer.status = ListLoadMoreFooterViewStatusNoMore;
        } else {
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
        }
    }];
    
    [self.vm.loadedSuccess subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            if (self.refreshControl.isRefreshing) [self.refreshControl endRefreshing];
            if ([self.loadingIndicator isAnimating]) [self.loadingIndicator stopAnimating];
            [self.tableView reloadData];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadedFailure subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.refreshControl endRefreshing];
            if ([self.loadingIndicator isAnimating]) [self.loadingIndicator stopAnimating];
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:x style:BannerStyleWarning onViewController:nil];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadedError subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.refreshControl endRefreshing];
            if ([self.loadingIndicator isAnimating]) [self.loadingIndicator stopAnimating];
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:@"请检查是否已连接网络" style:BannerStyleWarning onViewController:nil];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.readCacheCompleted subscribeCompleted:^{
        @strongify(self);
        void(^_)(void) = ^void() {
            [self.tableView reloadData];
            [self.vm loadData];
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar removeBottomLine];
}

- (void)setupSubviews {
    self.tableView.rowHeight = [ItemTableViewCell cellHeight];
    self.tableView.backgroundColor = [UIColor colorWithHexString: @"#f6f6f6"];
    [self.tableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@-%@", [ItemTableViewCell reuseIdentifier], NSStringFromClass([self class])]];
    self.tableView.showsVerticalScrollIndicator = YES;
    
    // 设置 tableview 的下拉刷新
    self.tableView.refreshControl = self.refreshControl;
    
    // 设置 tableview 最下面的点击加载
    self.tableView.tableFooterView = self.footer;
    
    [self.loadingIndicator stopAnimating];
}

- (void)actionRefresh:(UIRefreshControl *)sender {
    [self.vm reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiewahSlang *slang = self.vm.items[indexPath.row];
    NSDictionary *userInfo = @{@"identifier": slang.identifier,
                               SlangDetailVCSlangKey: slang.item,
                               SlangDetailVCPronunciationKey: slang.pronunciation,
                               };
    [self performSegueWithIdentifier:@"showSlangDetail" sender:userInfo];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@-%@", [ItemTableViewCell reuseIdentifier], NSStringFromClass([self class])];
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    MiewahSlang *slang = self.vm.items[indexPath.row];
    cell.lbItem.text = slang.item;
    cell.lbDetailA.text = slang.pronunciation;
    cell.lbDetailB.text = slang.meaning;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSDictionary *)userInfo {
    if ([segue.identifier isEqualToString:@"showSlangDetail"]) {
        SlangDetailViewController *vc = segue.destinationViewController;
        [vc setWordIdentifier:[userInfo objectForKey:@"identifier"]];
        NSDictionary *info = @{
                               SlangDetailVCSlangKey: [userInfo objectForKey:SlangDetailVCSlangKey],
                               SlangDetailVCPronunciationKey: [userInfo objectForKey:SlangDetailVCPronunciationKey],
                               };
        [vc setInitialInfo: info];
    }
}

- (MiewahItemType)miewahItemType {
    return MiewahItemTypeSlang;
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

- (SlangsViewModel *)vm {
    if (_vm == nil) {
        _vm = [[SlangsViewModel alloc] init];
    }
    return _vm;
}

@end

@implementation SlangsViewController(loadMoreFooter)
- (void)footerWillLoadMore:(ListLoadMoreFooterView *)footer {
    [self.vm loadData];
}
@end
