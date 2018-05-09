//
//  EditViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditViewController.h"
#import "UINavigationBar+BottomLine.h"
#import "CharacterEditViewController.h"
#import "WordEditViewController.h"
#import "SlangEditViewController.h"

#import "EditViewModel.h"
#import "UIConstants.h"

@interface EditViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *segSection;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) CharacterEditViewController *vcCharacter;
@property (nonatomic, strong) WordEditViewController *vcWord;
@property (nonatomic, strong) SlangEditViewController *vcSlang;
@property (nonatomic, weak) UIViewController *currentSubvc;

@property (nonatomic, strong) EditViewModel *vm;

@end

@implementation EditViewController

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

- (void)dealloc {
#if DEBUG
    NSLog(@"%@: deallocs", [self class]);
#endif
}

- (void)linkSignals {
    @weakify(self);
    [self.vm.ItemTypeSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^void() {
            [self switchSubvc];
        };
        runOnMainThread(_)
    }];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar removeBottomLine];
    
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionDismiss)];
    self.navigationItem.leftBarButtonItem = itemCancel;
}

- (void)setupSubviews {
    [self.segSection addTarget:self action:@selector(actionChangeSection:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchSubvc {
    UIViewController *oldVC = self.currentSubvc;
    UIViewController *newVC = nil;
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

- (void)displaySubvc:(UIViewController *)vc {
    [self addChildViewController:vc];
    vc.view.frame = self.containerView.bounds;
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)hideSubvc:(UIViewController *)vc {
    if (vc == nil) return;
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

- (void)actionChangeSection:(UISegmentedControl *)sender {
    self.itemType = sender.selectedSegmentIndex;
}

- (void)actionDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setItemType:(MiewahItemType)itemType {
    self.vm.itemType = @(itemType);
}

- (EditViewModel *)vm {
    if (_vm == nil) {
        _vm = [[EditViewModel alloc] init];
    }
    return _vm;
}

- (CharacterEditViewController *)vcCharacter {
    if (_vcCharacter == nil) {
        _vcCharacter = [[CharacterEditViewController alloc] init];
    }
    return _vcCharacter;
}

- (WordEditViewController *)vcWord {
    if (_vcWord == nil) {
        _vcWord = [[WordEditViewController alloc] init];
    }
    return _vcWord;
}

- (SlangEditViewController *)vcSlang {
    if (_vcSlang == nil) {
        _vcSlang = [[SlangEditViewController alloc] init];
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
