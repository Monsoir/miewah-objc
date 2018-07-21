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
#import "UIScrollView+Snapshot.h"

NSString * const ShareItemKey = @"share-item";
NSString * const ShareMeaningKey = @"share-meaning";
NSString * const ShareSentenceKey = @"share-sentence";

static NSString *MeaningPrompt = @"意义";
static NSString *SentencesPrompt = @"例句";

@interface ShareView()
@property (nonatomic, strong) UILabel *lbItem;
@property (nonatomic, strong) UILabel *lbMeaningPrompt;
@property (nonatomic, strong) UILabel *lbMeaning;
@property (nonatomic, strong) UILabel *lbSentencePrompt;
@property (nonatomic, strong) UILabel *lbSentence;
@property (nonatomic, strong) UIScrollView *backingScrollableView;
@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) NSDictionary *userInfo;

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
        _userInfo = userInfo;
        _didInitialLayout = NO;
        
        [self setupSubviews];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)setupSubviews {
    [self addSubview:self.backingScrollableView];
    [self.backingScrollableView addSubview:self.container];
    
    [self.container addSubview:self.lbItem];
    [self.container addSubview:self.lbMeaningPrompt];
    [self.container addSubview:self.lbMeaning];
    [self.container addSubview:self.lbSentencePrompt];
    [self.container addSubview:self.lbSentence];
    [self configureShareContent];
}

- (void)updateConstraints {
    
    if (self.didInitialLayout == NO) {
        
        [self.backingScrollableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11, *)) {
                make.edges.equalTo(self.safeAreaLayoutGuide);
            } else {
                make.edges.equalTo(self.layoutGuides);
            }
        }];
        
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backingScrollableView);
            make.width.equalTo(self.backingScrollableView);
        }];
        
        NSArray<UIView *> *views = @[self.lbItem, self.lbMeaningPrompt, self.lbMeaning, self.lbSentencePrompt, self.lbSentence];
        __block UIView *lastView = nil;
        
        for (UIView *view in views) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.container).offset(8);
                if (lastView == nil) {
                    make.top.equalTo(self.container).offset(8);
                    make.size.mas_equalTo(CGSizeMake(110, 110));
                } else {
                    make.top.equalTo(lastView.mas_bottom).offset(8);
                    make.right.lessThanOrEqualTo(self.container);
                    make.height.mas_greaterThanOrEqualTo(30);
                }
                lastView = view;
            }];
        }
        
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView);
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}

- (void)configureShareContent {
    NSString *item = self.userInfo[ShareItemKey];
    NSString *meaning = self.userInfo[ShareMeaningKey];
    NSString *sentence = self.userInfo[ShareSentenceKey];
    
    self.lbItem.text = item;
    
    UIFont *meaningFont = [UIFont fontWithName:@"PingFangSC-Medium" size:25];
    NSDictionary *meaningAttributes = @{
                                        NSFontAttributeName: meaningFont,
                                        };
    self.lbMeaning.attributedText = [[NSAttributedString alloc] initWithString:meaning attributes:meaningAttributes];
    
    UIFont *sentenceFont = [UIFont fontWithName:@"PingFangSC-Medium" size:25];
    NSDictionary *sentenceAttributes = @{
                                         NSFontAttributeName: sentenceFont,
                                         };
    self.lbSentence.attributedText = [[NSAttributedString alloc] initWithString:sentence attributes:sentenceAttributes];
}

- (UIImage *)snapshot {
    return [self.backingScrollableView snapshot];
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

- (UILabel *)lbMeaningPrompt {
    if (_lbMeaningPrompt == nil) {
        _lbMeaningPrompt = [[UILabel alloc] init];
        _lbMeaningPrompt.textColor = [UIColor lightGrayColor];
        _lbMeaningPrompt.font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:20];
        _lbMeaningPrompt.text = MeaningPrompt;
    }
    return _lbMeaningPrompt;
}

- (UILabel *)lbMeaning {
    if (_lbMeaning == nil) {
        _lbMeaning = [[UILabel alloc] init];
    }
    return _lbMeaning;
}

- (UILabel *)lbSentencePrompt {
    if (_lbSentencePrompt == nil) {
        _lbSentencePrompt = [[UILabel alloc] init];
        _lbSentencePrompt.textColor = [UIColor lightGrayColor];
        _lbSentencePrompt.font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:20];
        _lbSentencePrompt.text = SentencesPrompt;
    }
    return _lbSentencePrompt;
}

- (UILabel *)lbSentence {
    if (_lbSentence == nil) {
        _lbSentence = [[UILabel alloc] init];
        _lbSentence.numberOfLines = 0;
    }
    return _lbSentence;
}

- (UIView *)container {
    if (_container == nil) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIScrollView *)backingScrollableView {
    if (_backingScrollableView == nil) {
        _backingScrollableView = [[UIScrollView alloc] init];
    }
    return _backingScrollableView;
}

@end
