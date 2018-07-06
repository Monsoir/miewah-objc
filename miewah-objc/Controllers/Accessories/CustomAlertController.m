//
//  CustomAlertController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CustomAlertController.h"

@interface CustomAlertController ()

@property (nonatomic, strong) UIViewController *customVC;

@end

@implementation CustomAlertController

- (instancetype)initWithTitle:(NSString *)title customViewController:(UIViewController *)customVC style:(UIAlertControllerStyle)style {
    self = [[super class] alertControllerWithTitle:title message:nil preferredStyle:style];
    if (self) {
        _customVC = customVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setValue:self.customVC forKey:@"contentViewController"];
    self.preferredContentSize = self.customVC.preferredContentSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
