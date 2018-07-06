//
//  CustomAlertController.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertController : UIAlertController

- (instancetype)initWithTitle:(NSString *)title customViewController:(UIViewController *)customVC style:(UIAlertControllerStyle)style;

@end
