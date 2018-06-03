//
//  ItemEditExtraInfoViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "ItemEditExtraInfoViewController.h"
#import "EditExtraInfoViewModel.h"
#import "TypingBoardViewController.h"
#import "UINavigationBar+BottomLine.h"
#import "NewMiewahAsset.h"
#import "EditPreviewViewController.h"
#import "EditRecordTableViewCell.h"

#import "UIView+RoundCorner.h"
#import "UIColor+Hex.h"
#import "UIConstants.h"

static NSString *CellIdentifier = @"ItemEditExtraInfoViewControllerCell";
static CGFloat RecordButtonHeight = 40;
static CGFloat RecordButtonWidth = 200;

@interface ItemEditExtraInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *btnRecord;
@property (nonatomic, strong) UILabel *lbPrompt;

@property (nonatomic, copy) NSString *countDownPrompt;

@property (nonatomic, strong) EditExtraInfoViewModel *vm;

@end

@implementation ItemEditExtraInfoViewController

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
    [self.btnRecord maskRoundedCornersWithRadius:10];
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
    
    if (self.vm.type == MiewahItemTypeCharacter) {
        [self.vm.inputMethodsSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            void (^_)(void) = ^void() {
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            };
            runOnMainThread(_);
        }];
    }
    
    [self.vm.recordURLSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void (^_)(void) = ^() {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.startRecordingSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^() {
            [self.btnRecord setTitle:@"按住录音" forState:UIControlStateNormal];
            [self addPromptLabel];
            [UIView setAnimationsEnabled:NO];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.recordingSubject subscribeNext:^(NSDictionary * _Nullable x) {
        @strongify(self);
        NSInteger counter = [[x valueForKey:@"counter"] integerValue];
        void(^_)(void) = ^() {
            self.lbPrompt.text = [NSString stringWithFormat:@"%ld", (long)counter];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.finishRecordingSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^() {
            self.btnRecord.enabled = NO;
            [self.btnRecord setTitle:@"按住录音" forState:UIControlStateNormal];
            self.btnRecord.enabled = YES;
            [self removePromptLable];
            [UIView setAnimationsEnabled:YES];
        };
        runOnMainThread(_);
    }];
    
    [self.vm.abortRecordingSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^() {
            [self.btnRecord setTitle:@"按住录音" forState:UIControlStateNormal];
            [self removePromptLable];
            [UIView setAnimationsEnabled:YES];
        };
        runOnMainThread(_);
    }];
}

- (void)setupNavigationBar {
    switch (self.vm.type) {
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnRecord];
    
    [self.btnRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(RecordButtonWidth, RecordButtonHeight));
        
        CGFloat bottomOffset = 15;
        if (@available(iOS 11, *)) {
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-bottomOffset);
        } else {
            make.bottom.equalTo(self.view.layoutGuides).offset(-bottomOffset);
        }
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide);
        } else {
            make.top.left.right.equalTo(self.view.layoutGuides);
        }
        make.bottom.equalTo(self.btnRecord.mas_top).offset(-8);
    }];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.vm.sectionANames.count;
        case 1:
            return self.vm.sectionBNames.count;
            
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSString *prompt = self.vm.sectionANames[indexPath.row];
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
    } else if (indexPath.section == 1) {
        EditRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditRecordTableViewCell reuseIdentifier]];
        if (cell == nil) {
            cell = [[EditRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EditRecordTableViewCell reuseIdentifier]];
        }
        NSString *prompt = self.vm.sectionBNames[indexPath.row];
        cell.textLabel.text = prompt;
        cell.hasContent = self.vm.recordURL.length > 0;
        
        @weakify(self);
        cell.howToPlay = ^{
            @strongify(self);
            [self.vm playRecord];
        };
        
        cell.howToDelete = ^{
            @strongify(self);
            [self.vm deleteRecord];
        };
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) return;
    
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

#pragma mark - Actions

- (void)actionPreview {
    // 保存
    [self.vm saveExtraInfos];
    
    // 跳转
    EditPreviewViewController *vc = [[EditPreviewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addPromptLabel {
    if (_lbPrompt == nil) {
        [self.view addSubview:self.lbPrompt];
        [self.lbPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view.safeAreaLayoutGuide);
            make.height.mas_equalTo(150);
            make.bottom.equalTo(self.btnRecord.mas_top).offset(-10);
        }];
    } else {
        self.lbPrompt.hidden = NO;
    }
    self.lbPrompt.text = [NSString stringWithFormat:@"%ld", RecordDuration];
}

- (void)removePromptLable {
    self.lbPrompt.hidden = YES;
}

- (void)actionStartRecording:(UIButton *)sender {
    [self.vm startRecording];
}

- (void)actionFinishRecording:(UIButton *)sender {
    if (self.vm.isRecording) {
        [self.vm finishRecording];
    }
}

- (void)actionResumeRecording:(UIButton *)sender {
    if (self.vm.isRecording) {
        [sender setTitle:@"松开完成录音" forState:UIControlStateNormal];
    }
}

- (void)actionWillAbortRecording:(UIButton *)sender {
    if (self.vm.isRecording) {
        [sender setTitle:@"松开取消录音" forState:UIControlStateNormal];
    }
}

- (void)actionAbortRecording:(UIButton *)sender {
    [self.vm abortRecording];
}

#pragma mark - Accessors

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
//        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (UIButton *)btnRecord {
    if (_btnRecord == nil) {
        _btnRecord = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnRecord.backgroundColor = [UIColor colorWithHexString:@"#E8F0F9"];
        [_btnRecord setTitle:@"按住录音" forState:UIControlStateNormal];
        [_btnRecord setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnRecord addTarget:self action:@selector(actionStartRecording:) forControlEvents:UIControlEventTouchDown];
        [_btnRecord addTarget:self action:@selector(actionFinishRecording:) forControlEvents:UIControlEventTouchUpInside];
        [_btnRecord addTarget:self action:@selector(actionWillAbortRecording:) forControlEvents:UIControlEventTouchDragOutside];
        [_btnRecord addTarget:self action:@selector(actionResumeRecording:) forControlEvents:UIControlEventTouchDragInside];
        [_btnRecord addTarget:self action:@selector(actionAbortRecording:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _btnRecord;
}

- (UILabel *)lbPrompt {
    if (_lbPrompt == nil) {
        _lbPrompt = [[UILabel alloc] init];
        _lbPrompt.numberOfLines = 0;
        _lbPrompt.textAlignment = NSTextAlignmentCenter;
        _lbPrompt.font = [UIFont systemFontOfSize:30];
        _lbPrompt.backgroundColor = self.btnRecord.backgroundColor;
    }
    return _lbPrompt;
}

- (EditExtraInfoViewModel *)vm {
    if (_vm == nil) {
        _vm = [[EditExtraInfoViewModel alloc] init];
    }
    return _vm;
}

@end
