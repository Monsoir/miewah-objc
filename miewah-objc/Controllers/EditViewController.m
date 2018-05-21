//
//  EditViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditViewController.h"
#import "UINavigationBar+BottomLine.h"
#import "ItemEditBasicInfoViewController.h"
#import "NewMiewahAsset.h"

#import "EditViewModel.h"
#import "UIConstants.h"

@interface EditViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *segSection;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) ItemEditBasicInfoViewController *vcCharacter;
@property (nonatomic, strong) ItemEditBasicInfoViewController *vcWord;
@property (nonatomic, strong) ItemEditBasicInfoViewController *vcSlang;
@property (nonatomic, weak) ItemEditBasicInfoViewController *currentSubvc;
@property (nonatomic, strong) UIBarButtonItem *itemNext;

@property (nonatomic, strong) EditViewModel *vm;

@property (nonatomic, strong) NSDictionary *newCharacterFieldNames;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self setupNotifications];
    [self linkSignals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EditAssetToExtraInfosEnableNotificationName object:nil];
#if DEBUG
    NSLog(@"%@: deallocs", [self class]);
#endif
}

- (void)linkSignals {
    @weakify(self);
    [self.vm.itemTypeSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^void() {
            // 改变 UI
            [self switchSubvc];
            
            // 改变实例
            MiewahItemType type = [x unsignedIntegerValue];
            [NewMiewahAsset sharedAsset].type = type;
            
            // 发消息禁用下一步按钮
            [DefaultNotificationCenter postNotificationName:EditAssetToExtraInfosEnableNotificationName
                                                     object:nil
                                                   userInfo:@{
                                                              EditAssetToExtraInfosEnableNotificationUserInfoKey: @(NO),
                                                              }];
        };
        runOnMainThread(_)
    }];
}

- (void)setupNotifications {
    @weakify(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:EditAssetToExtraInfosEnableNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self);
        BOOL enableNext = [note.userInfo[EditAssetToExtraInfosEnableNotificationUserInfoKey] boolValue];
        self.itemNext.enabled = enableNext;
    }];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar removeBottomLine];
    
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionDismiss)];
    self.navigationItem.leftBarButtonItem = itemCancel;
    
    self.navigationItem.rightBarButtonItem = self.itemNext;
}

- (void)setupSubviews {
    [self.segSection addTarget:self action:@selector(actionChangeSection:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchSubvc {
    ItemEditBasicInfoViewController *oldVC = self.currentSubvc;
    ItemEditBasicInfoViewController *newVC = nil;
    MiewahItemType type = (MiewahItemType)[self.vm.itemType unsignedIntegerValue];
    switch (type) {
        case MiewahItemTypeCharacter:
            newVC = self.vcCharacter;
            break;
        case MiewahItemTypeWord:
            newVC = self.vcWord;
            break;
        case MiewahItemTypeSlang:
            newVC = self.vcSlang;
            break;
            
        default:
            break;
    }
    NSAssert(newVC != nil, @"EditViewController: new vc is nil");
    
    [self hideSubvc:oldVC];
    [self displaySubvc:newVC];
    self.currentSubvc = newVC;
}

- (void)displaySubvc:(ItemEditBasicInfoViewController *)vc {
    [self addChildViewController:vc];
    vc.view.frame = self.containerView.bounds;
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)hideSubvc:(ItemEditBasicInfoViewController *)vc {
    if (vc == nil) return;
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

- (void)actionChangeSection:(UISegmentedControl *)sender {
    self.itemType = sender.selectedSegmentIndex;
    NSDictionary *userInfo = @{
                               EditAssetResetTypeNotificationUserInfoKey: self.vm.itemType,
                               };
    [DefaultNotificationCenter postNotificationName:EditAssetResetNotificationName
                                             object:nil
                                           userInfo:userInfo];
}

- (void)actionDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionNext {
    
}

- (void)setItemType:(MiewahItemType)itemType {
    self.vm.itemType = @(itemType);
}

#pragma mark - Lazy initialization

- (EditViewModel *)vm {
    if (_vm == nil) {
        _vm = [[EditViewModel alloc] init];
    }
    return _vm;
}

- (UIBarButtonItem *)itemNext {
    if (_itemNext == nil) {
        _itemNext = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(actionNext)];
    }
    return _itemNext;
}

- (NSDictionary *)newCharacterFieldNames {
    if (_newCharacterFieldNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"NewCharacterFieldNames" ofType:@"plist"];
        _newCharacterFieldNames = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _newCharacterFieldNames;
}

- (ItemEditBasicInfoViewController *)vcCharacter {
    if (_vcCharacter == nil) {
        _vcCharacter = [[ItemEditBasicInfoViewController alloc] initWithType:MiewahItemTypeCharacter];
    }
    return _vcCharacter;
}

- (ItemEditBasicInfoViewController *)vcWord {
    if (_vcWord == nil) {
        _vcWord = [[ItemEditBasicInfoViewController alloc] initWithType:MiewahItemTypeWord];
    }
    return _vcWord;
}

- (ItemEditBasicInfoViewController *)vcSlang {
    if (_vcSlang == nil) {
        _vcSlang = [[ItemEditBasicInfoViewController alloc] initWithType:MiewahItemTypeSlang];
    }
    return _vcSlang;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
