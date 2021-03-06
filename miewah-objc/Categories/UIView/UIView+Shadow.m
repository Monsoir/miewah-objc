//
//  UIView+Shadow.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)simpleShadowWithOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity color:(UIColor *)color {
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowColor = color.CGColor;
    // 提前告知阴影路径，防止离屏渲染
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
}

@end
