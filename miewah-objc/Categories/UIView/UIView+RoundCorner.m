//
//  UIView+RoundCorner.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIView+RoundCorner.h"

@implementation UIView (RoundCorner)

- (void)maskRoundedCorners:(UIRectCorner)corners cornerRadius:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = maskPath.CGPath;
    self.layer.masksToBounds = YES;
    self.layer.mask = shapeLayer;
}

@end
