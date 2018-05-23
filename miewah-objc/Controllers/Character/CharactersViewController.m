//
//  WordsMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharactersViewController.h"
#import "ShortItemTableViewCell.h"
#import "ListLoadMoreFooterView.h"
#import "CharactersViewModel.h"
#import "UIConstants.h"
#import "NotificationBanner.h"
#import "CharacterDetailViewController.h"
#import "MiewahCharacter.h"

#import "UIColor+Hex.h"
#import "UINavigationBar+BottomLine.h"

@interface CharactersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ListLoadMoreFooterView *footer;

@property (nonatomic, strong) CharactersViewModel *vm;

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
    [self configureNewOneItem];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShortItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShortItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    MiewahCharacter *character = self.vm.items[indexPath.row];
    cell.lbWord.text = character.item;
    cell.lbPronounce.text = character.pronunciation;
    cell.lbMeaning.text = character.meaning;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiewahCharacter *character = self.vm.items[indexPath.row];
    NSDictionary *userInfo = @{
                               @"identifier": character.identifier,
                               CharacterDetailVCWordKey: character.item,
                               CharacterDetailVCPronunciationKey: character.pronunciation,
                               };
    [self performSegueWithIdentifier:@"showCharacterDetail" sender:userInfo];
}

- (void)actionRefresh:(UIRefreshControl *)sender {
    [self.vm reloadData];
}

- (CharactersViewModel *)vm {
    if (_vm == nil) {
        _vm = [[CharactersViewModel alloc] init];
    }
    return _vm;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSDictionary *)userInfo {
    if ([segue.identifier isEqualToString:@"showCharacterDetail"]) {
        CharacterDetailViewController *vc = segue.destinationViewController;
        [vc setCharacterIdentifier:[userInfo objectForKey:@"identifier"]];
        NSDictionary *info = @{
                               CharacterDetailVCWordKey: [userInfo objectForKey:CharacterDetailVCWordKey],
                               CharacterDetailVCPronunciationKey: [userInfo objectForKey:CharacterDetailVCPronunciationKey],
                               };
        [vc setInitialInfo: info];
    }
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
