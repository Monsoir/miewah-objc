//
//  UIView+Nib.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

- (UIView *)loadViewFromNib {
    Class aClass = [self class];
    NSBundle *currentBundle = [NSBundle bundleForClass:aClass];
    NSString *name = [[NSStringFromClass(aClass) componentsSeparatedByString:@"."] lastObject];
    UINib *nib = [UINib nibWithNibName:name bundle:currentBundle];
    
    UIView *contentView = [[nib instantiateWithOwner:self options:nil] firstObject];
    [self addSubview:contentView];
    [self addConstraintsToContentView:contentView];
    return contentView;
}

- (void)addConstraintsToContentView:(UIView *)contentView {
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [NSLayoutConstraint activateConstraints:@[leadingConstraint, trailingConstraint, topConstraint, bottomConstraint]];
}

@end
