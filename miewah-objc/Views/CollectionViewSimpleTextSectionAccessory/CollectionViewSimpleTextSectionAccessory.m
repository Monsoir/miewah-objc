//
//  CollectionViewSimpleTextSectionAccessory.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/13.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CollectionViewSimpleTextSectionAccessory.h"
#import <Masonry/Masonry.h>

@interface CollectionViewSimpleTextSectionAccessory()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, assign) BOOL didInitialLayout;
@property (nonatomic, strong) NSDictionary *titleAttributes;

@end

@implementation CollectionViewSimpleTextSectionAccessory

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addSubview:self.btn];
}

- (void)updateConstraints {
    if (self.didInitialLayout == NO) {
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        self.didInitialLayout = YES;
    }
    [super updateConstraints];
}

- (void)actionDidSelect {
    if (self.delegate) {
        [self.delegate simpleTextSectionAccessoryDidSelect:self];
    }
}

#pragma mark - Accessors

- (void)setTitle:(NSString *)title {
    _title = title;
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:_title attributes:self.titleAttributes];
    [self.btn setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn addTarget:self action:@selector(actionDidSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (NSDictionary *)titleAttributes {
    if (_titleAttributes == nil) {
        _titleAttributes = @{
                             NSForegroundColorAttributeName: [UIColor blackColor],
                             NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size:18],
                             };
    }
    return _titleAttributes;
}

@end
