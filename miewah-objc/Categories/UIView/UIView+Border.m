//
//  UIView+Border.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)addBottomBorder:(CGFloat)inset height:(CGFloat)height color:(UIColor *)color {
    CALayer *bottomBorderLayer = [CALayer layer];
    bottomBorderLayer.frame = CGRectMake(inset, self.frame.size.height - 1, self.frame.size.width - 2 * inset, height);
    bottomBorderLayer.backgroundColor = color.CGColor;
    bottomBorderLayer.masksToBounds = YES;
    [self.layer addSublayer:bottomBorderLayer];
}

@end
