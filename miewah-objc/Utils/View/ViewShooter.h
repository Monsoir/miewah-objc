//
//  ViewShooter.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewShooter : NSObject

/**
 对某个 view 进行截图

 @param aView 截图目标 view
 @return 截图
 */
+ (UIImage *)shootAtView:(UIView *)aView;

@end
