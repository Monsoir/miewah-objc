//
//  WordsMieMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsViewController.h"
#import "ShortItemTableViewCell.h"
#import "NotificationBanner.h"
#import "ListLoadMoreFooterView.h"
#import "WordDetailViewController.h"
#import "MiewahWord.h"

#import "WordsViewModel.h"
#import "UIConstants.h"

#import "UIColor+Hex.h"
#import "UINavigationBar+BottomLine.h"

@interface WordsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ListLoadMoreFooterView *footer;

@property (nonatomic, strong) WordsViewModel *vm;

@end

@interface WordsViewController (loadMoreFooter)<ListLoadMoreFooterViewDelegate>
@end

@implementation WordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSignals];
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
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:x style:BannerStyleWarning onViewController:self.navigationController];
        };
        
        runOnMainThread(_);
    }];
    
    [self.vm.loadedError subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.refreshControl endRefreshing];
            if ([self.loadingIndicator isAnimating]) [self.loadingIndicator stopAnimating];
            self.footer.status = ListLoadMoreFooterViewStatusNotLoading;
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:@"请检查是否已连接网络" style:BannerStyleWarning onViewController:self.navigationController];
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar removeBottomLine];
}

- (void)setupSubviews {
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.tableView registerNib:[UINib nibWithNibName:[ShortItemTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShortItemTableViewCell reuseIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    
    // 设置 tableview 的下拉刷新
    self.tableView.refreshControl = self.refreshControl;
    
    // 设置 tableview 最下面的点击加载
    self.tableView.tableFooterView = self.footer;
}

- (void)actionRefresh:(UIRefreshControl *)sender {
    [self.vm reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiewahWord *word = self.vm.items[indexPath.row];
    NSDictionary *userInfo = @{@"identifier": word.identifier,
                               WordDetailVCWordKey: word.word,
                               WordDetailVCPronunciationKey: word.pronunciation,
                               };
    [self performSegueWithIdentifier:@"showWordDetail" sender:userInfo];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShortItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShortItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    MiewahWord *word = self.vm.items[indexPath.row];
    cell.lbWord.text = word.word;
    cell.lbPronounce.text = word.pronunciation;
    cell.lbMeaning.text = word.meaning;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSDictionary *)userInfo {
    if ([segue.identifier isEqualToString:@"showWordDetail"]) {
        WordDetailViewController *vc = segue.destinationViewController;
        [vc setWordIdentifier:[userInfo objectForKey:@"identifier"]];
        NSDictionary *info = @{
                               WordDetailVCWordKey: [userInfo objectForKey:WordDetailVCWordKey],
                               WordDetailVCPronunciationKey: [userInfo objectForKey:WordDetailVCPronunciationKey],
                               };
        [vc setInitialInfo: info];
    }
}

- (MiewahItemType)miewahItemType {
    return MiewahItemTypeWord;
}

- (WordsViewModel *)vm {
    if (_vm == nil) {
        _vm = [[WordsViewModel alloc] init];
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
