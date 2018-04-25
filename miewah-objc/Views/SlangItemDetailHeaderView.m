//
//  SlangItemDetailHeaderView.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangItemDetailHeaderView.h"

#import "UIView+Border.h"
#import "UIView+RoundCorner.h"

@implementation SlangItemDetailHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self decorateSubviews];
}

- (void)decorateSubviews {
    [self addBottomBorder:5 height:1 color:UIColor.lightGrayColor];
    [self.lbSlang maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(10, 10)];
}

@end
