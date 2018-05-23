//
//  ItemEditExtraInfoViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ItemEditExtraInfoViewController.h"
#import "EditExtraInfoViewModel.h"
#import "TypingBoardViewController.h"
#import "UINavigationBar+BottomLine.h"
#import "NewMiewahAsset.h"
#import "EditPreviewViewController.h"

#import "UIView+Layout.h"
#import "UIColor+Hex.h"
#import "UIConstants.h"

NSString *CellIdentifier = @"ItemEditExtraInfoViewControllerCell";

@interface ItemEditExtraInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EditExtraInfoViewModel *vm;
@property (nonatomic, assign) MiewahItemType type;

@end

@implementation ItemEditExtraInfoViewController

- (instancetype)initWithType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

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

- (void)linkSignals {
    @weakify(self);
    [self.vm.sourceSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^void() {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.sentencesSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^() {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        runOnMainThread(_);
    }];
    
    if (self.type == MiewahItemTypeCharacter) {
        [self.vm.inputMethodsSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            void (^_)(void) = ^void() {
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            };
            runOnMainThread(_);
        }];
    }
}

- (void)setupNavigationBar {
    switch (self.type) {
        case MiewahItemTypeCharacter:
            self.title = @"新建 - 字";
            break;
        case MiewahItemTypeWord:
            self.title = @"新建 - 词组";
            break;
        case MiewahItemTypeSlang:
            self.title = @"新建 - 短语";
            break;
            
        default:
            break;
    }
    
    UIBarButtonItem *itemPreview = [[UIBarButtonItem alloc] initWithTitle:@"暂存并预览" style:UIBarButtonItemStylePlain target:self action:@selector(actionPreview)];
    self.navigationItem.rightBarButtonItem = itemPreview;
    self.navigationItem.backBarButtonItem.title = @"";
    
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = itemBack;
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    NSArray<NSLayoutConstraint *> *constraints = [self.tableView fullLayoutConstraintsToParentView:self.view];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)actionPreview {
    // 保存
    [self.vm saveExtraInfos];
    
    // 跳转
    EditPreviewViewController *vc = [[EditPreviewViewController alloc] initWithAssetType:self.type];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.sectionNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *prompt = self.vm.sectionNames[indexPath.row];
    cell.textLabel.text = prompt;
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = self.vm.source;
            break;
        case 1:
            cell.detailTextLabel.text = self.vm.sentences;
            break;
        case 2:
            cell.detailTextLabel.text = self.vm.inputMethods;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *placeholder = @"请输入内容";
    TypingBoardViewController *vc = [[TypingBoardViewController alloc] initWithPlaceholder:placeholder];
    TypingBoardCompletion completion = nil;
    @weakify(self);
    switch (indexPath.row) {
        case 0:
        {
            vc.title = @"出处";
            [vc setContent:self.vm.source];
            completion = ^(NSString *content) {
                @strongify(self);
                self.vm.source = content;
            };
        }
            break;
        case 1:
        {
            vc.title = @"例句";
            [vc setContent:self.vm.sentences];
            completion = ^(NSString *content) {
                @strongify(self);
                self.vm.sentences = content;
            };
        }
            break;
        case 2:
        {
            vc.title = @"输入法";
            [vc setContent:self.vm.inputMethods];
            completion = ^(NSString *content) {
                @strongify(self);
                self.vm.inputMethods = content;
            };
        }
            break;
            
        default:
            break;
    }
    vc.completion = completion;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [nc.navigationBar removeBottomLine];
    [self.navigationController presentViewController:nc animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Accessors

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.bounces = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (EditExtraInfoViewModel *)vm {
    if (_vm == nil) {
        _vm = [[EditExtraInfoViewModel alloc] initWithType:self.type];
    }
    return _vm;
}

@end
