//
//  CollectionViewSimpleTextPlaceholderBackgoundView.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/12.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CollectionViewSimpleTextPlaceholderBackgoundView.h"
#import <Masonry/Masonry.h>

@interface CollectionViewSimpleTextPlaceholderBackgoundView()

@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, assign) BOOL didInitialLayout;

@end

@implementation CollectionViewSimpleTextPlaceholderBackgoundView

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
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
    [self addSubview:self.lbTitle];
}

- (void)updateConstraints {
    if (self.didInitialLayout == NO) {
        [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.didInitialLayout = YES;
    }
    [super updateConstraints];
}

#pragma mark - Accessors

- (UILabel *)lbTitle {
    if (_lbTitle == nil) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.font = [UIFont systemFontOfSize:25];
        _lbTitle.text = self.title;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lbTitle;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.lbTitle.text = _title;
}

@end
