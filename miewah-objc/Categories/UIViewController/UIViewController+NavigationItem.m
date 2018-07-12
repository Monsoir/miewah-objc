//
//  UIViewController+NavigationItem.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/12.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIViewController+NavigationItem.h"

@implementation UIViewController (NavigationItem)

- (void)removeBackButtonItemTitle {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

@end
