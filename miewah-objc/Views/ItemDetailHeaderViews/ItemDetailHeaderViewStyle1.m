//
//  ItemDetailHeaderViewStyle1.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ItemDetailHeaderViewStyle1.h"
#import <Masonry/Masonry.h>
#import "UIView+Border.h"
#import "UIView+RoundCorner.h"

@interface ItemDetailHeaderViewStyle1()

@property (nonatomic, strong) UILabel *lbItem;
@property (nonatomic, strong) UILabel *lbPronunce;

@property (nonatomic, assign) BOOL didInitialLayout;

@end

@implementation ItemDetailHeaderViewStyle1

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

+ (CGSize)preDefinedSize {
    return CGSizeMake(375, 150);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.lbItem];
    [self addSubview:self.lbPronunce];
}

- (void)updateConstraints {
    
    if (self.didInitialLayout == NO) {
        
        [self.lbItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 110));
        }];
        
        [self.lbPronunce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbItem);
            make.left.equalTo(self.lbItem.mas_right).offset(15);
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self decorateSubviews];
}

- (void)decorateSubviews {
    [self addBottomBorder:5 height:1 color:UIColor.lightGrayColor];
    [self.lbItem maskRoundedCorners:UIRectCornerAllCorners cornerRadius:CGSizeMake(10, 10)];
}

#pragma mark - Accessors

- (UILabel *)lbItem {
    if (_lbItem == nil) {
        _lbItem = [[UILabel alloc] init];
        _lbItem.font = [UIFont systemFontOfSize:45];
        _lbItem.backgroundColor = [UIColor lightGrayColor];
        _lbItem.textAlignment = NSTextAlignmentCenter;
    }
    return _lbItem;
}

- (UILabel *)lbPronunce {
    if (_lbPronunce == nil) {
        _lbPronunce = [[UILabel alloc] init];
        _lbPronunce.font = [UIFont systemFontOfSize:25];
    }
    return _lbPronunce;
}

@end
