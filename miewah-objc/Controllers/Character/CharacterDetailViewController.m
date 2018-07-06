//
//  CharacterViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterDetailViewController.h"
#import "ShortItemDetailHeaderView.h"
#import "CharacterDetailViewModel.h"
#import "UIConstants.h"
#import "NotificationBanner.h"
#import "MiewahCharacter.h"
#import "MiewahWord.h"
#import "ItemIntroductionCell.h"
#import "CustomAlertController.h"
#import "ShareItemViewController.h"

static NSString *SectionIdentifier = @"section-header";

@interface CharacterDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ShortItemDetailHeaderView *header;
@property (nonatomic, strong) UIBarButtonItem *loadingIndicatorItem;
@property (nonatomic, strong) UIBarButtonItem *shareItem;

@property (nonatomic, strong) CharacterDetailViewModel *vm;

@end

@implementation CharacterDetailViewController

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
//            self.navigationItem.rightBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem = self.shareItem;
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
            self.navigationItem.rightBarButtonItem = nil;
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = self.loadingIndicatorItem;
    self.title = self.vm.asset.item;
}

- (void)actionShare {
    NSDictionary *shareInfo = @{
                                AssetItemKey: alwaysString(self.vm.asset.item),
                                AssetSentencesKey: alwaysString(self.vm.asset.sentences),
                                AssetMeaningKey: alwaysString(self.vm.asset.meaning),
                                };
    ShareItemViewController *shareVC = [[ShareItemViewController alloc] initWithShareInfo:shareInfo];
    CustomAlertController *alert = [[CustomAlertController alloc] initWithTitle:@"Share" customViewController:shareVC style:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
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
    _vm = [[CharacterDetailViewModel alloc] initWithInfo:info];
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

- (UIBarButtonItem *)shareItem {
    if (_shareItem == nil) {
        _shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionShare)];
    }
    return _shareItem;
}

@end
