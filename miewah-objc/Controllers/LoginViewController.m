//
//  LoginViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LoginViewController.h"

#import "UIView+Border.h"
#import "UIViewController+Keyboard.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *ivAvatar;
@property (nonatomic, weak) IBOutlet UITextField *tfUsername;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tfUsername addBottomBorder:0 height:1 color:UIColor.blackColor];
    [self.tfPassword addBottomBorder:0 height:1 color:UIColor.blackColor];
}

- (void)setupSubviews {
    [self setupTapToDismissKeyboard];
    self.tfUsername.backgroundColor = UIColor.whiteColor;
    self.tfPassword.backgroundColor = UIColor.whiteColor;
}

- (IBAction)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionLogin:(UIButton *)sender {
    
}

@end
