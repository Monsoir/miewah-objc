//
//  LocalAssetCollectionViewSectionHeader.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/12.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LocalAssetCollectionViewSectionHeader.h"
#import <Masonry/Masonry.h>

@interface LocalAssetCollectionViewSectionHeader()

@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIButton *btnIndicator;

@property (nonatomic, assign) BOOL didInitialLayout;

@end

@implementation LocalAssetCollectionViewSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

+ (NSString *)reusableIdentifier {
    return NSStringFromClass([self class]);
}

- (void)initialize {
    [self addSubview:self.lbTitle];
    [self addSubview:self.btnIndicator];
}

- (void)updateConstraints {
    
    if (self.didInitialLayout == NO) {
        
        static CGFloat Height = 50;
        [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(8);
            make.height.mas_equalTo(Height);
        }];
        
        [self.btnIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(8);
            make.height.mas_equalTo(Height);
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}


#pragma mark - Accessors

- (void)setTitle:(NSString *)title {
    _title = title;
    self.lbTitle.text = _title;
}

- (void)setIndicatorTitle:(NSString *)indicatorTitle {
    _indicatorTitle = indicatorTitle;
    [self.btnIndicator setTitle:_indicatorTitle forState:UIControlStateNormal];
}

- (UILabel *)lbTitle {
    if (_lbTitle == nil) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.numberOfLines = 0;
    }
    return _lbTitle;
}

- (UIButton *)btnIndicator {
    if (_btnIndicator == nil) {
        _btnIndicator = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _btnIndicator;
}

@end
