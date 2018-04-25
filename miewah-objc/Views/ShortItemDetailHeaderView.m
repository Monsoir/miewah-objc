//
//  ShortItemDetailHeaderView.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ShortItemDetailHeaderView.h"

#import "UIView+Border.h"
#import "UIView+RoundCorner.h"

@implementation ShortItemDetailHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self decorateSubviews];
}

- (void)decorateSubviews {
    [self addBottomBorder:5 height:1 color:UIColor.lightGrayColor];
    [self.lbWord maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(10, 10)];
}

- (IBAction) actionPronouce:(UIButton *)sender {
    [self.delegate headerPronuns];
}

- (IBAction)actionRecord:(UIButton *)sender {
    [self.delegate headerRecord];
}

@end
