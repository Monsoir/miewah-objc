//
//  WordDetailViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordDetailViewController.h"
#import "WordDetailViewModel.h"
#import "ItemIntroductionCell.h"
#import "UIConstants.h"
#import "NotificationBanner.h"
#import "ShortItemDetailHeaderView.h"
#import "MiewahCharacter.h"
#import "MiewahWord.h"

static NSString *SectionIdentifier = @"section-header";

@interface WordDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ShortItemDetailHeaderView *header;

@property (nonatomic, strong) WordDetailViewModel *vm;

@end

@implementation WordDetailViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)linkSignals {
    @weakify(self);
    
    [self.vm.readFavorComplete subscribeCompleted:^{
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.navigationItem setRightBarButtonItems:@[self.shareItem, self.favorItem]];
            self.header.lbWord.text = self.vm.asset.item;
            self.header.lbPronounce.text = self.vm.asset.pronunciation;
            [self.tableView reloadData];
        };
        runOnMainThread(_);
        [self.vm loadData];
    }];
    
    [self.vm.loadedSuccess subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.navigationItem setRightBarButtonItems:@[self.shareItem, self.favorItem]];
            self.header.lbWord.text = self.vm.asset.item;
            self.header.lbPronounce.text = self.vm.asset.pronunciation;
            [self.tableView reloadData];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadedFailure subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:nil style:BannerStyleWarning onViewController:self.navigationController];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadingSignal subscribeNext:^(id  _Nullable x) {
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
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:SectionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:[ItemIntroductionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ItemIntroductionCell reuseIdentifier]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.header.lbWord.text = self.vm.asset.item;
    self.header.lbPronounce.text = self.vm.asset.pronunciation;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionIdentifier];
    header.textLabel.text = self.vm.sectionNames[section];
    return header;
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

#pragma mark - Accessors

@synthesize vm = _vm;

- (void)setInitialInfo:(NSDictionary *)info {
    _vm = [[WordDetailViewModel alloc] initWithInfo:info];
}

@end
