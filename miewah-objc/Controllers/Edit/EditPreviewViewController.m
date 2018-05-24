//
//  EditPreviewViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditPreviewViewController.h"
#import "EditPreviewViewModel.h"
#import "NewMiewahAsset.h"

#import "EditPreviewViewHeader.h"
#import "ItemIntroductionCell.h"
#import "UIConstants.h"
#import "LoginViewController.h"
#import "NotificationBanner.h"

#import "UIView+Layout.h"

static NSString *SectionIdentifier = @"section-header";

@interface EditPreviewViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EditPreviewViewHeader *header;
@property (nonatomic, strong) UIBarButtonItem *itemSubmit;
@property (nonatomic, strong) UIBarButtonItem *itemSubmitting;

@property (nonatomic, strong) EditPreviewViewModel *vm;

@end

@implementation EditPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSignals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.tableHeaderView = self.header;
}

- (void)linkSignals {
    @weakify(self);
    
    [self.vm.postSuccess subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^() {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        };
        runOnMainThread(_);
    }];
    
    [self.vm.postFailure subscribeNext:^(NSDictionary *_Nullable x) {
        @strongify(self);
        NSNumber *errorCodeO = [x valueForKey:MiewahRequestErrorCodeKey];
        if (errorCodeO != nil && [errorCodeO unsignedIntegerValue] == MiewahRequestErrorCodeUnauthorized) {
            void(^_)(void) = ^(void) {
                self.navigationItem.rightBarButtonItem = self.itemSubmit;
                [self postLoginController];
            };
            runOnMainThread(_);
            return;
        }
        
        NSString *msg = [x valueForKey:MiewahRequestErrorMessageKey];
        void(^_)(void) = ^() {
            self.navigationItem.rightBarButtonItem = self.itemSubmit;
            [NotificationBanner displayABannerWithTitle:@"提交失败" detail:msg style:BannerStyleWarning onViewController:self.navigationController];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.postError subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^(void) {
            [NotificationBanner displayABannerWithTitle:@"请求失败" detail:@"请检查是否已连接网络" style:BannerStyleWarning onViewController:self.navigationController];
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = self.itemSubmit;
    
    NSString *title = nil;
    switch (self.vm.type) {
        case MiewahItemTypeCharacter:
            title = @"预览 - 新字";
            break;
        case MiewahItemTypeWord:
            title = @"预览 - 新词";
            break;
        case MiewahItemTypeSlang:
            title = @"预览 - 新短语";
            break;
            
        default:
            break;
    }
    
    self.title = title;
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:[self.tableView fullLayoutConstraintsToParentView:self.view]];
    
    self.header.item = CurrentEditingAsset.item;
    self.header.prononuciation = CurrentEditingAsset.pronunciation;
}

- (void)actionSubmit {
    if ([self.vm postData]) {
        self.navigationItem.rightBarButtonItem = self.itemSubmitting;
    } else {
        self.navigationItem.rightBarButtonItem = self.itemSubmit;
    }
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

- (void)postLoginController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    vc.forcingLogin = YES;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Accessors
- (EditPreviewViewHeader *)header {
    if (_header == nil) {
        _header = [[EditPreviewViewHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, [EditPreviewViewHeader height])];
    }
    return _header;
}

- (UIBarButtonItem *)itemSubmit {
    if (_itemSubmit == nil) {
        _itemSubmit = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(actionSubmit)];
    }
    return _itemSubmit;
}

- (UIBarButtonItem *)itemSubmitting {
    if (_itemSubmitting == nil) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
        [indicator startAnimating];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _itemSubmitting = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    }
    return _itemSubmitting;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 80;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = 40;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:SectionIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:[ItemIntroductionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ItemIntroductionCell reuseIdentifier]];
    }
    return _tableView;
}

- (EditPreviewViewModel *)vm {
    if (_vm == nil) {
        _vm = [[EditPreviewViewModel alloc] init];
    }
    return _vm;
}

@end
