//
//  MiewahListViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahListViewController.h"
#import "EditViewController.h"
#import "LoginViewController.h"
#import "MiewahUser.h"

@interface MiewahListViewController ()

@end

@implementation MiewahListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureNewOneItem {
    self.navigationItem.rightBarButtonItem = self.itemNewOne;
}

- (void)toNewItemController {
//    BOOL isLogin = [MiewahUser isLogin];
//    isLogin ? [self postNewItemController] : [self postLoginController];
    [self postNewItemController];
}

- (void)postLoginController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    vc.forcingLogin = YES;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)postNewItemController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditViewController *vc = [sb instantiateViewControllerWithIdentifier:@"EditViewController"];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}

- (MiewahItemType)miewahItemType {
    return MiewahItemTypeNone;
}

- (UIBarButtonItem *)itemNewOne {
    if (_itemNewOne == nil) {
        _itemNewOne = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toNewItemController)];
    }
    return _itemNewOne;
}

@end
