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
@property (nonatomic, strong) UIBarButtonItem *loadingIndicatorItem;

@property (nonatomic, strong) WordDetailViewModel *vm;

@end

@implementation WordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSignals];
    
    [self.vm loadData];
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
    [self.vm.loadedSuccess subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            self.navigationItem.rightBarButtonItem = nil;
            self.header.lbWord.text = self.vm.asset.item;
            self.header.lbPronounce.text = self.vm.asset.pronunciation;
            [self.tableView reloadData];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.loadedFailure subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:x style:BannerStyleWarning onViewController:self.navigationController];
            self.navigationItem.rightBarButtonItem = nil;
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = self.loadingIndicatorItem;
    self.title = self.vm.asset.item;
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

- (void)setInitialInfo:(NSDictionary *)info {
    _vm = [[WordDetailViewModel alloc] initWithInfo:info];
}

- (UIBarButtonItem *)loadingIndicatorItem {
    if (_loadingIndicatorItem == nil) {
        UIActivityIndicatorView *anIndicator = [[UIActivityIndicatorView alloc] init];
        anIndicator.hidesWhenStopped = YES;
        anIndicator.color = UIColor.darkGrayColor;
        [anIndicator startAnimating];
        _loadingIndicatorItem = [[UIBarButtonItem alloc] initWithCustomView:anIndicator];
    }
    return _loadingIndicatorItem;
}

@end
