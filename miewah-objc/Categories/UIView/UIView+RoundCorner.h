//
//  UIView+RoundCorner.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundCorner)

/**
 绘制圆角，使用 cornerRadius, 只能一次性设置四个角

 @param radius 圆角半径
 */
- (void)maskRoundedCornersWithRadius:(CGFloat)radius;

/**
 绘制圆角，使用 UIBezierPath, 可以指定哪些角需要圆角

 @param corners 需要圆角的位置
 @param cornerRadii 圆角的半径
 */
- (void)maskRoundedCorners:(UIRectCorner)corners cornerRadius: (CGSize)cornerRadii;

@end
