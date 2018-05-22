//
//  MiewahListViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahListViewController.h"
#import "EditViewController.h"
#import "TypingBoardViewController.h"

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
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    EditViewController *vc = [sb instantiateViewControllerWithIdentifier:@"EditViewController"];
//    vc.itemType = [self miewahItemType];
    
    TypingBoardViewController *vc = [[TypingBoardViewController alloc] initWithPlaceholder:@"placeholder"];
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
