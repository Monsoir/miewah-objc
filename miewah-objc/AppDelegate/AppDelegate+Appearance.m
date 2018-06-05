//
//  AppDelegate+Appearance.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/5.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AppDelegate+Appearance.h"

@implementation AppDelegate (Appearance)

- (void)configureAppTintColor {
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName: UIColor.blackColor,
                                 };
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setTintColor:UIColor.blackColor];
    
    [[UISegmentedControl appearance] setTintColor:UIColor.blackColor];
}

@end
