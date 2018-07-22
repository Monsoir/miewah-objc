//
//  SlangDetailViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangDetailViewController.h"
#import "ItemIntroductionCell.h"
#import "SlangDetailViewModel.h"
#import "NotificationBanner.h"
#import "UIConstants.h"
#import "ItemDetailHeaderViewStyle2.h"
#import <Masonry/Masonry.h>
#import "PlainTextFooter.h"

static NSString *SectionIdentifier = @"section-header";

@interface SlangDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ItemDetailHeaderViewStyle2 *header;
@property (nonatomic, strong) PlainTextFooter *plainTextFooter;

@property (nonatomic, strong) SlangDetailViewModel *vm;

@end

@implementation SlangDetailViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = [ItemDetailHeaderViewStyle2 preDefinedSize];
    self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, size.height);
    self.tableView.tableHeaderView = self.header;
    
    self.plainTextFooter.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    self.tableView.tableFooterView = self.plainTextFooter;
}

- (void)linkSignals {
    @weakify(self);
    
    [self.vm.readFavorComplete subscribeCompleted:^{
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.navigationItem setRightBarButtonItems:@[self.shareItem, self.favorItem]];
            self.header.lbItem.text = self.vm.asset.item;
            self.header.lbPronunce.text = self.vm.asset.pronunciation;
            
            // 当自动更新完成后，才将 table view 的更新控件赋值到
            // 避免多次重复刷新产生不必要的 bug
            self.tableView.refreshControl = self.tableRefresher;
            [self.plainTextFooter setDetail:[self.vm.asset normalFormatUpdatedAt]];
            [self.tableView reloadData];
        };
        runOnMainThread(_);
        [self.vm loadData];
    }];
    
    [self.vm.loadedSuccess subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.navigationItem setRightBarButtonItems:@[self.shareItem, self.favorItem]];
            self.header.lbItem.text = self.vm.asset.item;
            self.header.lbPronunce.text = self.vm.asset.pronunciation;
            [self.tableRefresher endRefreshing];
            [self.plainTextFooter setDetail:[self.vm.asset normalFormatUpdatedAt]];
            [self.tableView reloadData];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadedFailure subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.tableRefresher endRefreshing];
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:x style:BannerStyleWarning onViewController:self.navigationController];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadingSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BOOL loading = [x boolValue];
        void (^_)(void) = ^void() {
            if (loading) {
                [self.navigationItem setRightBarButtonItems:@[self.shareItem, self.favorItem, self.loadingIndicatorItem]];
            } else {
                [self.navigationItem setRightBarButtonItems:@[self.shareItem, self.favorItem]];
            }
        };
        runOnMainThread(_);
    }];
    
    [self.vm.favorSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BOOL favored = [x boolValue];
        void(^_)(void) = ^(void) {
            self.favorItem.tintColor = favored ? [UIColor redColor] : self.navigationController.navigationBar.tintColor;
        };
        runOnMainThread(_);
    }];
    
    [self.vm.assetExistSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BOOL assetExist = [x boolValue];
        void(^_)(void) = ^(void) {
            self.favorItem.enabled = assetExist;
            self.shareItem.enabled = assetExist;
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
    
    self.header.lbItem.text = self.vm.asset.item;
    self.header.lbPronunce.text = self.vm.asset.pronunciation;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.vm.sectionNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemIntroductionCell reuseIdentifier] forIndexPath:indexPath];
    cell.lbIntroductions.text = self.vm.displayContents[indexPath.section];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionIdentifier];
    header.textLabel.text = self.vm.sectionNames[section];
    return header;
}

#pragma mark - Accessors

@synthesize vm = _vm;

- (void)setInitialInfo:(NSDictionary *)info {
    _vm = [[SlangDetailViewModel alloc] initWithInfo:info];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.sectionHeaderHeight = 40;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:SectionIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:[ItemIntroductionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ItemIntroductionCell reuseIdentifier]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (ItemDetailHeaderViewStyle2 *)header {
    if (_header == nil) {
        _header = [[ItemDetailHeaderViewStyle2 alloc] init];
    }
    return _header;
}

- (PlainTextFooter *)plainTextFooter {
    if (_plainTextFooter == nil) {
        _plainTextFooter = [[PlainTextFooter alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100)];
        _plainTextFooter.lbTtitle.textColor = [UIColor lightGrayColor];
        _plainTextFooter.prompt = @"最后更新于";
    }
    return _plainTextFooter;
}

@end
