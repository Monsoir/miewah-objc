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

#import "UIView+Layout.h"

static NSString *SectionIdentifier = @"section-header";

@interface EditPreviewViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EditPreviewViewHeader *header;

@property (nonatomic, strong) EditPreviewViewModel *vm;

@end

@implementation EditPreviewViewController

- (instancetype)initWithAssetType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        _vm = [[EditPreviewViewModel alloc] initWithAssetType:type];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.tableHeaderView = self.header;
}

- (void)setupNavigationBar {
    UIBarButtonItem *itemSubmit = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(actionSubmit)];
    self.navigationItem.rightBarButtonItem = itemSubmit;
    
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
}

- (void)actionSubmit {
    
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
- (EditPreviewViewHeader *)header {
    if (_header == nil) {
        _header = [[EditPreviewViewHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, [EditPreviewViewHeader height])];
    }
    return _header;
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

@end
