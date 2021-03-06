//
//  UIView+Layout.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (NSArray<NSLayoutConstraint *> *)fullLayoutConstraintsToParentView:(UIView *)parentView {
    
    if (parentView == nil) return nil;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
//    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
//    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
//    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    UILayoutGuide *layoutGuide = parentView.safeAreaLayoutGuide;
    NSLayoutConstraint *topConstraint = [self.topAnchor constraintEqualToAnchor:layoutGuide.topAnchor];
    NSLayoutConstraint *bottomConstraint = [self.bottomAnchor constraintEqualToAnchor:layoutGuide.bottomAnchor];
    NSLayoutConstraint *leadingConstraint = [self.leadingAnchor constraintEqualToAnchor:layoutGuide.leadingAnchor];
    NSLayoutConstraint *trailingConstraint = [self.trailingAnchor constraintEqualToAnchor:layoutGuide.trailingAnchor];
    
    return @[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint];
}

@end
