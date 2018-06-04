//
//  EditRecordTableViewCell.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditRecordTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"

static CGFloat ButtonLength = 35;

@interface EditRecordTableViewCell()

@property (nonatomic, strong) UIButton *btnPlay;
@property (nonatomic, strong) UIButton *btnDel;

@property (nonatomic, assign) BOOL didInitialLayout;
@property (nonatomic, strong) UIColor *enablePlayColor;
@property (nonatomic, strong) UIColor *enableDelColor;
@property (nonatomic, strong) UIColor *disableColor;

@end

@implementation EditRecordTableViewCell

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.didInitialLayout = NO;
    _enabled = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.btnPlay];
    [self.contentView addSubview:self.btnDel];
}

- (void)updateConstraints {
    
    if (self.didInitialLayout == NO) {
        
        [self.btnDel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(ButtonLength, ButtonLength));
            CGFloat rightMargin  = 10;
            if (@available(iOS 11, *)) {
                make.right.equalTo(self.contentView.safeAreaLayoutGuide).offset(-rightMargin);
            } else {
                make.right.equalTo(self.contentView.layoutGuides).offset(-rightMargin);
            }
        }];
        
        [self.btnPlay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(ButtonLength, ButtonLength));
            make.right.equalTo(self.btnDel.mas_left).offset(-10);
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}

- (void)setEnabled:(BOOL)hasContent {
    _enabled = hasContent;
    
    if (_enabled) {
        self.btnPlay.tintColor = self.enablePlayColor;
        self.btnDel.tintColor = self.enableDelColor;
    } else {
        self.btnPlay.tintColor = self.disableColor;
        self.btnDel.tintColor = self.disableColor;
    }
}

- (void)actionPlay {
    if (self.howToPlay) {
        self.howToPlay();
    }
}

- (void)actionDelete {
    if (self.howToDelete) {
        self.howToDelete();
    }
}

- (UIColor *)enablePlayColor {
    if (_enablePlayColor == nil) {
        _enablePlayColor = [UIColor colorWithHexString:@"#1DD5CD"];
    }
    return _enablePlayColor;
}

- (UIColor *)enableDelColor {
    if (_enableDelColor == nil) {
        _enableDelColor = [UIColor colorWithHexString:@"#FF4676"];
    }
    return _enableDelColor;
}

- (UIColor *)disableColor {
    if (_disableColor == nil) {
        _disableColor = [UIColor colorWithHexString:@"#E2EEF8"];
    }
    return _disableColor;
}

- (UIButton *)btnPlay {
    if (_btnPlay == nil) {
        _btnPlay = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *i = [[UIImage imageNamed:@"play"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_btnPlay setImage:i forState:UIControlStateNormal];
        _btnPlay.tintColor = [UIColor lightGrayColor];
        [_btnPlay addTarget:self action:@selector(actionPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPlay;
}

- (UIButton *)btnDel {
    if (_btnDel == nil) {
        _btnDel = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *i = [[UIImage imageNamed:@"delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_btnDel setImage:i forState:UIControlStateNormal];
        _btnDel.tintColor = [UIColor lightGrayColor];
        [_btnDel addTarget:self action:@selector(actionDelete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDel;
}

@end
