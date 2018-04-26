//
//  UIViewController+Keyboard.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/26.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIViewController+Keyboard.h"

@implementation UIViewController (Keyboard)

- (void)setupTapToDismissKeyboard {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gesture];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
