//
//  UIView+Shadow.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

- (void)simpleShadowWithOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity color:(UIColor *)color;

@end
