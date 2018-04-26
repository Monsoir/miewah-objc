//
//  ShortItemTableViewCell.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ShortItemTableViewCell.h"

#import "UIView+RoundCorner.h"
#import "UIView+Shadow.h"
#import "UIColor+Hex.h"

// 缩放动画时间
static const CGFloat AnimatingTime = 0.1;
static const CGFloat ScaleX = 0.9;
static const CGFloat ScaleY = 0.9;

@implementation ShortItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self initialize];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(ScaleX, ScaleY);
        [UIView animateWithDuration:AnimatingTime animations:^{
            self.transform = scaleTransform;
        }];
    } else {
        [UIView animateWithDuration:AnimatingTime animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self roundContainer];
    [self shadowContainer];
}

- (void)roundContainer {
    CGFloat cornerRadius = 10;
    [self.container maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(cornerRadius, cornerRadius)];
    [self.lbWord maskRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopLeft cornerRadius:CGSizeMake(cornerRadius, cornerRadius)];
}

- (void)shadowContainer {
    CGSize offset = CGSizeMake(-2, -2);
    CGFloat radius = 10;
    CGFloat opacity = 0.8;
    UIColor *color = [UIColor colorWithHexString:@"#c7c7c7"];
    
    [self.container simpleShadowWithOffset:offset radius:radius opacity:opacity color:color];
}

- (void)initialize {
    self.backgroundColor = UIColor.clearColor;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
