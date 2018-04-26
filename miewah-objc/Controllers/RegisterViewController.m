//
//  RegisterViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIView+Border.h"
#import "UIViewController+Keyboard.h"

@interface RegisterViewController ()

@property (nonatomic, weak) IBOutlet UITextField *tfUsername;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UITextField *tfPasswordConfirmation;

@end

@implementation RegisterViewController

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
    [self.tfPasswordConfirmation addBottomBorder:0 height:1 color:UIColor.blackColor];
}

- (void)setupSubviews {
    [self setupTapToDismissKeyboard];
    self.tfUsername.backgroundColor = UIColor.whiteColor;
    self.tfPassword.backgroundColor = UIColor.whiteColor;
    self.tfPasswordConfirmation.backgroundColor = UIColor.whiteColor;
}

- (IBAction)actionRegister:(UIButton *)sender {
    
}

- (IBAction)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
