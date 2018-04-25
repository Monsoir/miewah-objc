//
//  ColorBlockBasicTableViewCell.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ColorBlockBasicTableViewCell.h"

#import "UIView+RoundCorner.h"

@implementation ColorBlockBasicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self roundColorLeader];
}

- (void)roundColorLeader {
    CGFloat radius = 8;
    [self.colorLeader maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(radius, radius)];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
