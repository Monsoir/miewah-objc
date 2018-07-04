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

static NSString *SectionIdentifier = @"section-header";

NSString * const CharacterDetailVCWordKey = @"character";
NSString * const CharacterDetailVCPronunciationKey = @"pronunciation";

@interface CharacterDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ShortItemDetailHeaderView *header;
@property (nonatomic, strong) UIBarButtonItem *loadingIndicatorItem;

@property (nonatomic, strong) CharacterDetailViewModel *vm;

@property (nonatomic, copy) NSString *tempCharacter;
@property (nonatomic, copy) NSString *tempPronunciation;

@end

@implementation CharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSignals];
    
    [self.vm loadDetail];
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
    
    [self.vm.loadedError subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:@"请检查是否已连接网络" style:BannerStyleWarning onViewController:self.navigationController];
            self.navigationItem.rightBarButtonItem = nil;
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = self.loadingIndicatorItem;
    self.title = self.tempCharacter;
}

- (void)setupSubviews {
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:SectionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:[ItemIntroductionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ItemIntroductionCell reuseIdentifier]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.header.lbWord.text = self.tempCharacter;
    self.header.lbPronounce.text = self.tempPronunciation;
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

- (void)setCharacterIdentifier:(NSString *)identifier {
    if (_vm) {
        _vm.identifier = identifier;
    } else {
        _vm = [[CharacterDetailViewModel alloc] initWithIdentifier:identifier];
    }
}

- (void)setInitialInfo:(NSDictionary *)info {
    _tempCharacter = [info objectForKey:CharacterDetailVCWordKey];
    _tempPronunciation = [info objectForKey:CharacterDetailVCPronunciationKey];
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
