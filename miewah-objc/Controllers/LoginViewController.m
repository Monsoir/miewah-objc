//
//  LoginViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginResponseObject.h"
#import "MiewahUser.h"
#import "FoundationConstants.h"
#import "UIConstants.h"

#import "NotificationBanner.h"

#import "UIView+Border.h"
#import "UIViewController+Keyboard.h"
#import "UIColor+Hex.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *ivAvatar;
@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (nonatomic, strong) LoginViewModel *vm;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    [self linkSignals];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.forcingLogin) {
        [NotificationBanner displayABannerWithTitle:@"请先登录" detail:@"" style:BannerStyleWarning onViewController:self];
    }
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
}

- (void)setupSubviews {
    [self setupTapToDismissKeyboard];
    self.tfEmail.backgroundColor = UIColor.whiteColor;
    self.tfPassword.backgroundColor = UIColor.whiteColor;
}

- (void)linkSignals {
    @weakify(self);
    RAC(self.vm, email) = self.tfEmail.rac_textSignal;
    RAC(self.vm, password) = self.tfPassword.rac_textSignal;
    
    [self.vm.enableLoginSignal subscribeNext:^(NSNumber * _Nullable enabled) {
        @strongify(self);
        runOnMainThread(^{
            self.btnLogin.backgroundColor = [enabled boolValue] ? [UIColor colorWithHexString:@"#66cffc"] : UIColor.grayColor;
            self.btnLogin.enabled = [enabled boolValue];
        });
    }];
    
    // 登录成功
    [self.vm.loginSuccess subscribeNext:^(LoginResponseObject * _Nullable x) {
        // 设置当前已登录的用户
        MiewahUser *thisUser = [MiewahUser thisUser];
        thisUser.name = @"Monsoir";
        thisUser.loginToken = x.token;
        [thisUser saveUserInfo];
    } completed:^{
        // 发送通知，使得「我的」页面能及时更新
//        [NSNotificationCenter.defaultCenter postNotificationName:LoginCompleteNotificationName object:nil];
        
        @strongify(self);
        runOnMainThread(^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
    // 登录失败，关于业务流程的失败
    [self.vm.loginFailure subscribeNext:^(NSArray<NSString *> * _Nullable x) {
        @strongify(self);
        runOnMainThread(^{
            [NotificationBanner displayABannerWithTitle:@"登录失败" detail:[x componentsJoinedByString:@", "] style:BannerStyleWarning onViewController:self];
        });
    }];
    
    // 登录失败，关于工程上的失败
    [self.vm.loginError subscribeError:^(NSError * _Nullable error) {
        @strongify(self);
        runOnMainThread(^{
            [NotificationBanner displayABannerWithTitle:@"登录失败" detail:@"网络请求失败" style:BannerStyleWarning onViewController:self];
        });
    }];
}

- (IBAction)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionLogin:(UIButton *)sender {
    [self.vm postLogin];
}

- (LoginViewModel *)vm {
    if (_vm == nil) {
        _vm = [[LoginViewModel alloc] init];
    }
    return _vm;
}

@end
