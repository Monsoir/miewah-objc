//
//  UIView+Layout.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

/**
 将当前 view 布局设置为铺满父 view

 @param parentView 父 view
 @return 铺满父 view 的约束
 */
- (NSArray<NSLayoutConstraint *> *)fullLayoutConstraintsToParentView:(UIView *)parentView;

@end
