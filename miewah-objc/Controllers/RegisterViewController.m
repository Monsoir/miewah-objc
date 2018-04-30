//
//  RegisterViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewModel.h"
#import "NotificationBanner.h"

#import "UIView+Border.h"
#import "UIViewController+Keyboard.h"
#import "UIColor+Hex.h"

@interface RegisterViewController ()

@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UITextField *tfPasswordConfirmation;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@property (nonatomic, strong) RegisterViewModel *vm;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    [self linkSignals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", NSStringFromClass([self class]));
#endif
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tfEmail addBottomBorder:0 height:1 color:UIColor.blackColor];
    [self.tfPassword addBottomBorder:0 height:1 color:UIColor.blackColor];
    [self.tfPasswordConfirmation addBottomBorder:0 height:1 color:UIColor.blackColor];
}

- (void)setupSubviews {
    [self setupTapToDismissKeyboard];
    self.tfEmail.backgroundColor = UIColor.whiteColor;
    self.tfPassword.backgroundColor = UIColor.whiteColor;
    self.tfPasswordConfirmation.backgroundColor = UIColor.whiteColor;
}

- (void)linkSignals {
    @weakify(self);
    RAC(self.vm, email) = self.tfEmail.rac_textSignal;
    RAC(self.vm, password) = self.tfPassword.rac_textSignal;
    RAC(self.vm, passwordConfirmation) = self.tfPasswordConfirmation.rac_textSignal;
    
    [self.vm.enableRegisterSignal subscribeNext:^(NSNumber * _Nullable enabled) {
        @strongify(self);
        self.btnRegister.backgroundColor = [enabled boolValue] ? [UIColor colorWithHexString:@"#66cffc"] : UIColor.grayColor;
        self.btnRegister.enabled = [enabled boolValue];
    }];
    
    [self.vm.registerSuccess subscribeCompleted:^{
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showBannerWithTitle:@"注册成功" detail:@"" style:BannerStyleSuccess onViewController:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
    [self.vm.registerFailure subscribeNext:^(NSArray<NSString *> * _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showBannerWithTitle:@"注册失败" detail:[x componentsJoinedByString:@", "] style:BannerStyleWarning onViewController:self];
        });
    }];
    
    [self.vm.registerError subscribeError:^(NSError * _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showBannerWithTitle:@"注册失败" detail:@"网络请求失败" style:BannerStyleWarning onViewController:self];
        });
    }];
}

- (void)showBannerWithTitle:(NSString *)title detail:(NSString *)detail style:(BannerStyle)style onViewController:(UIViewController *)vc {
    [NotificationBanner displayABannerWithTitle:title detail:detail style:style onViewController:vc];
}

- (IBAction)actionRegister:(UIButton *)sender {
    NSLog(@"register");
    [self.vm postRegister];
}

- (IBAction)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (RegisterViewModel *)vm {
    if (_vm == nil) {
        _vm = [[RegisterViewModel alloc] init];
    }
    return _vm;
}

@end
