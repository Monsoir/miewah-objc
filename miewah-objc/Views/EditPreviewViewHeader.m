//
//  EditPreviewViewHeader.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditPreviewViewHeader.h"
#import "UIView+Border.h"

const CGFloat ButtonSize = 40;

@interface EditPreviewViewHeader()

@property (nonatomic, strong) UILabel *lbItem;
@property (nonatomic, strong) UILabel *lbPronounciation;
@property (nonatomic, strong) UIButton *btnPronounce;
@property (nonatomic, strong) UIButton *btnRecord;

@property (nonatomic, assign) BOOL needPrononucing;
@property (nonatomic, assign) BOOL needRecording;

@property (nonatomic, assign) BOOL didInitialLayout;

@end

@implementation EditPreviewViewHeader

+ (CGFloat)height {
    return 180;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithPrononucingNeed:(BOOL)needPrononucing recordingNeed:(BOOL)needRecording {
    self = [super init];
    if (self) {
        [self initialize];
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addBottomBorder:5 height:1 color:UIColor.lightGrayColor];
}

- (void)initialize {
    _needPrononucing = NO;
    _needRecording = NO;
    _didInitialLayout = NO;
}

- (void)setupSubviews {
    self.backgroundColor = UIColor.whiteColor;
    
    [self addSubview:self.lbItem];
    [self addSubview:self.lbPronounciation];
    
    [self addSubview:self.btnPronounce];
    [self addSubview:self.btnRecord];
    
    self.btnPronounce.enabled = self.needPrononucing;
    self.btnRecord.enabled = self.needRecording;
}

- (void)updateConstraints {
    
    if (self.didInitialLayout == false) {
        
        [NSLayoutConstraint activateConstraints:[self containerConstraints]];
        [NSLayoutConstraint activateConstraints:[self labelItemConstraints]];
        [NSLayoutConstraint activateConstraints:[self labelPrononuciationConstraints]];
        [NSLayoutConstraint activateConstraints:[self btnPronounceConstraints]];
        [NSLayoutConstraint activateConstraints:[self btnRecordConstraints]];
        
        self.didInitialLayout = true;
    }
    
    [super updateConstraints];
}

- (NSArray<NSLayoutConstraint *> *)containerConstraints {
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[[self class] height]];
    return @[heightConstraint];
}

- (NSArray<NSLayoutConstraint *> *)labelItemConstraints {
    UILayoutGuide *safeGuide = self.safeAreaLayoutGuide;
    NSLayoutConstraint *topConstraint = [self.lbItem.topAnchor constraintEqualToAnchor:safeGuide.topAnchor constant:8];
    NSLayoutConstraint *leadingConstraint = [self.lbItem.leadingAnchor constraintEqualToAnchor:safeGuide.leadingAnchor constant:15];
    NSLayoutConstraint *trailingConstraint = [self.lbItem.trailingAnchor constraintEqualToAnchor:safeGuide.trailingAnchor constant:-8];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.lbItem attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    return @[topConstraint, leadingConstraint, trailingConstraint, heightConstraint];
}

- (NSArray<NSLayoutConstraint *> *)labelPrononuciationConstraints {
    UILayoutGuide *safeGuide = self.safeAreaLayoutGuide;
    NSLayoutConstraint *topConstraint = [self.lbPronounciation.topAnchor constraintEqualToAnchor:self.lbItem.safeAreaLayoutGuide.bottomAnchor constant:8];
    NSLayoutConstraint *leadingConstraint = [self.lbPronounciation.leadingAnchor constraintEqualToAnchor:safeGuide.leadingAnchor constant:15];
    NSLayoutConstraint *trailingConstraint = [self.lbPronounciation.trailingAnchor constraintEqualToAnchor:safeGuide.trailingAnchor constant:-8];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.lbPronounciation attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25];
    return @[topConstraint, leadingConstraint, trailingConstraint, heightConstraint];
}

- (NSArray<NSLayoutConstraint *> *)btnPronounceConstraints {
    UILayoutGuide *safeGuide = self.safeAreaLayoutGuide;
    NSLayoutConstraint *bottomConstraint = [self.btnPronounce.bottomAnchor constraintEqualToAnchor:safeGuide.bottomAnchor constant:-8];
    NSLayoutConstraint *leadingConstraint = [self.btnPronounce.leadingAnchor constraintEqualToAnchor:safeGuide.leadingAnchor constant:15];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.btnPronounce attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ButtonSize];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.btnPronounce attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ButtonSize];
    return @[bottomConstraint, leadingConstraint, widthConstraint, heightConstraint];
}

- (NSArray<NSLayoutConstraint *> *)btnRecordConstraints {
    UILayoutGuide *safeGuide = self.safeAreaLayoutGuide;
    NSLayoutConstraint *bottomConstraint = [self.btnRecord.bottomAnchor constraintEqualToAnchor:safeGuide.bottomAnchor constant:-8];
    NSLayoutConstraint *leadingConstraint = [self.btnRecord.leadingAnchor constraintEqualToAnchor:self.btnPronounce.trailingAnchor constant:60];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.btnRecord attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ButtonSize];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.btnRecord attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ButtonSize];
    return @[bottomConstraint, leadingConstraint, widthConstraint, heightConstraint];
}

#pragma mark - Accessors

- (void)setItem:(NSString *)item {
    self.lbItem.text = item;
}

- (void)setPrononuciation:(NSString *)prononuciation {
    self.lbPronounciation.text = prononuciation;
}

- (UILabel *)lbItem {
    if (_lbItem == nil) {
        _lbItem = [[UILabel alloc] init];
        _lbItem.translatesAutoresizingMaskIntoConstraints = NO;
        _lbItem.font = [UIFont systemFontOfSize:45];
        _lbItem.text = @"---";
    }
    return _lbItem;
}

- (UILabel *)lbPronounciation {
    if (_lbPronounciation == nil) {
        _lbPronounciation = [[UILabel alloc] init];
        _lbPronounciation.translatesAutoresizingMaskIntoConstraints = NO;
        _lbPronounciation.font = [UIFont systemFontOfSize:25];
        _lbPronounciation.text = @"--";
    }
    return _lbPronounciation;
}

- (UIButton *)btnPronounce {
    if (_btnPronounce == nil) {
        _btnPronounce = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnPronounce setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
        _btnPronounce.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnPronounce;
}

- (UIButton *)btnRecord {
    if (_btnRecord == nil) {
        _btnRecord = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnRecord setImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
        _btnRecord.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnRecord;
}

@end
