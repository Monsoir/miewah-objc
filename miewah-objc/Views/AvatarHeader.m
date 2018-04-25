//
//  AvatarHeader.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AvatarHeader.h"

#import "UIView+RoundCorner.h"

@implementation AvatarHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self roundAvatar];
}

- (void)initialize {
    self.backgroundColor = UIColor.whiteColor;
}

- (void)roundAvatar {
    CGFloat radius = self.ivAvatar.bounds.size.width / 2;
    [self.ivAvatar maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(radius, radius)];
}

@end
