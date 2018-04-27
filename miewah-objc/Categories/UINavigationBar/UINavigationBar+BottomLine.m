//
//  UINavigationBar+BottomLine.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UINavigationBar+BottomLine.h"

@implementation UINavigationBar (BottomLine)

- (void)removeBottomLine {
//    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [[UIImage alloc] init];
}

@end
