//
//  ShareView.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ShareView.h"
#import <Masonry/Masonry.h>
#import "UIView+RoundCorner.h"

NSString * const ShareItemKey = @"share-item";
NSString * const ShareMeaningKey = @"share-meaning";
NSString * const ShareSentenceKey = @"share-sentence";

@interface ShareView()
@property (nonatomic, strong) UILabel *lbItem;
@property (nonatomic, strong) UILabel *lbMeaning;
@property (nonatomic, strong) UILabel *lbSentence;

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *meaning;
@property (nonatomic, copy) NSString *sentence;

@property (nonatomic, assign) BOOL didInitialLayout;
@end

@implementation ShareView

- (instancetype)init {
    NSAssert(false, @"use `initWithUserInfo:` instead");
    return nil;
}

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo {
    self = [super init];
    if (self) {
        _item = [userInfo valueForKey:ShareItemKey];
        _meaning = [userInfo valueForKey:ShareMeaningKey];
        _sentence = [userInfo valueForKey:ShareSentenceKey];
        _didInitialLayout = NO;
        
        [self setupSubviews];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)setupSubviews {
    [self addSubview:self.lbItem];
    [self addSubview:self.lbMeaning];
    [self addSubview:self.lbSentence];
    
    self.lbItem.text = self.item;
    if (self.item.length >= 3) self.lbItem.numberOfLines = 2;
    self.lbMeaning.text = self.meaning;
    self.lbSentence.text = self.sentence;
}

- (void)updateConstraints {
    
    if (self.didInitialLayout == NO) {
        
        [self.lbItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.centerX.equalTo(self).offset(-30);
            make.size.mas_equalTo(CGSizeMake(110, 110));
        }];
        
        [self.lbMeaning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbItem.mas_bottom).offset(8);
            make.centerX.equalTo(self.lbItem);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        [self.lbSentence mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbMeaning.mas_bottom).offset(8);
            make.centerX.equalTo(self.lbItem);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Accessors

- (UILabel *)lbItem {
    if (_lbItem == nil) {
        _lbItem = [[UILabel alloc] init];
        _lbItem.font = [UIFont systemFontOfSize:50];
        _lbItem.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        _lbItem.layer.cornerRadius = 10;
        _lbItem.textAlignment = NSTextAlignmentCenter;
        _lbItem.adjustsFontSizeToFitWidth = YES;
    }
    return _lbItem;
}

- (UILabel *)lbMeaning {
    if (_lbMeaning == nil) {
        _lbMeaning = [[UILabel alloc] init];
        _lbMeaning.font = [UIFont systemFontOfSize:25];
    }
    return _lbMeaning;
}

- (UILabel *)lbSentence {
    if (_lbSentence == nil) {
        _lbSentence = [[UILabel alloc] init];
    }
    return _lbSentence;
}

@end
