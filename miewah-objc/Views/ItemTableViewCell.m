//
//  ItemTableViewCell.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ItemTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import "UIView+Shadow.h"
#import "UIView+RoundCorner.h"

// 缩放动画时间
static const CGFloat AnimatingTime = 0.1;
static const CGFloat ScaleX = 0.9;
static const CGFloat ScaleY = 0.9;

@interface ItemTableViewCell()

@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) UILabel *lbItem;
@property (strong, nonatomic) UILabel *lbDetailA;
@property (strong, nonatomic) UILabel *lbDetailB;

@property (nonatomic, assign) BOOL didInitialLayout;

@end

@implementation ItemTableViewCell

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 180;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize offset = CGSizeMake(-2, -2);
    CGFloat radius = 8;
    CGFloat opacity = 0.8;
    UIColor *color = [UIColor colorWithHexString:@"#c7c7c7"];
    [self.container simpleShadowWithOffset:offset radius:radius opacity:opacity color:color];
    
//    [self.container maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(10, 10)];
    [self.container maskRoundedCornersWithRadius:10];
}

- (void)initialize {
    self.didInitialLayout = NO;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.container];
    [self.contentView addSubview:self.lbItem];
    [self.contentView addSubview:self.lbDetailA];
    [self.contentView addSubview:self.lbDetailB];
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

- (void)updateConstraints {
    
    if (self.didInitialLayout == NO) {
        
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 20, 10, 20));
        }];
        
        [self.lbItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.container).offset(8);
            make.left.equalTo(self.container).offset(8);
            make.right.equalTo(self.container).offset(-8);
            make.height.mas_equalTo(30);
        }];

        [self.lbDetailA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbItem.mas_bottom).offset(8);
            make.left.equalTo(self.lbItem);
            make.right.equalTo(self.lbItem);
        }];

        [self.lbDetailB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbDetailA.mas_bottom).offset(8);
            make.left.equalTo(self.lbItem);
            make.right.equalTo(self.lbItem);
            make.bottom.equalTo(self.container).offset(-8);
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}

- (UIView *)container {
    if (_container == nil) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = UIColor.whiteColor;
    }
    return _container;
}

- (UILabel *)lbItem {
    if (_lbItem == nil) {
        _lbItem = [[UILabel alloc] init];
        _lbItem.font = [UIFont systemFontOfSize:25];
    }
    return _lbItem;
}

- (UILabel *)lbDetailA {
    if (_lbDetailA == nil) {
        _lbDetailA = [[UILabel alloc] init];
        _lbDetailA.font = [UIFont systemFontOfSize:20];
    }
    return _lbDetailA;
}

- (UILabel *)lbDetailB {
    if (_lbDetailB == nil) {
        _lbDetailB = [[UILabel alloc] init];
        _lbDetailB.numberOfLines = 2;
        _lbDetailB.font = [UIFont systemFontOfSize:20];
    }
    return _lbDetailB;
}

@end
