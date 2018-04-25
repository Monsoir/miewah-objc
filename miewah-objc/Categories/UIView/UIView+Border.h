//
//  UIView+Border.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

/**
 简单添加底边

 @param inset 底边距离 view 两边的距离，这里指的是一边的距离，会自动计算两边
 @param height 底边高度
 @param color 底边颜色
 */
- (void)addBottomBorder:(CGFloat)inset height:(CGFloat)height color:(UIColor *)color;

@end
