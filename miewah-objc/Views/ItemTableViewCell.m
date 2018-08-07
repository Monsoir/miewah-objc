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
#import "UIView+Border.h"

static const CGFloat AccessoryFontSize = 12;

// 缩放动画时间
static const CGFloat AnimatingTime = 0.1;
static const CGFloat ScaleX = 0.9;
static const CGFloat ScaleY = 0.9;

@interface ItemTableViewCell()

@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) UILabel *lbItem;
@property (strong, nonatomic) UILabel *lbDetailA;
@property (strong, nonatomic) UILabel *lbDetailB;
@property (nonatomic, strong) UIView *accessoriesContainer;
@property (nonatomic, strong) UILabel *lbUpdateAt;

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
    
//    CGSize offset = CGSizeMake(-2, -2);
//    CGFloat radius = 8;
//    CGFloat opacity = 0.8;
//    UIColor *color = [UIColor colorWithHexString:@"#c7c7c7"];
//    [self.container simpleShadowWithOffset:offset radius:radius opacity:opacity color:color];
    
    [self.container maskRoundedCornersWithRadius:10];
    [self.accessoriesContainer addTopBorder:4 height:1 color:[UIColor colorWithHexString:@"#ececec"]];
}

- (void)initialize {
    self.didInitialLayout = NO;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.container];
    [self.contentView addSubview:self.lbItem];
    [self.contentView addSubview:self.lbDetailA];
    [self.contentView addSubview:self.lbDetailB];
    
    [self.contentView addSubview:self.accessoriesContainer];
    [self.accessoriesContainer addSubview:self.lbUpdateAt];
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
            make.height.mas_greaterThanOrEqualTo(30);
        }];
        
        [self.accessoriesContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbDetailB.mas_bottom).offset(8);
            make.bottom.equalTo(self.container).offset(-8);
            make.left.equalTo(self.lbItem);
            make.right.equalTo(self.lbItem);
        }];
        
        [self.lbUpdateAt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.accessoriesContainer);
            make.left.equalTo(self.accessoriesContainer);
        }];
        
        self.didInitialLayout = YES;
    }
    
    [super updateConstraints];
}

static NSDictionary *AccessoryAttributes = nil;
+ (NSDictionary *)accessoryAttributes {
    if (AccessoryAttributes == nil) {
        AccessoryAttributes = @{
                                NSForegroundColorAttributeName:[UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.0],
                                NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:AccessoryFontSize],
                                };
    }
    return AccessoryAttributes;
}

static NSTextAttachment *UpdatedAtAttachment = nil;
+ (NSTextAttachment *)updatedAtAttachment {
    if (UpdatedAtAttachment == nil) {
        UpdatedAtAttachment = [[NSTextAttachment alloc] init];
        UpdatedAtAttachment.image = [UIImage imageNamed:@"updatedAt"];
        CGFloat imageOffsetY = -3.0;
        UpdatedAtAttachment.bounds = CGRectMake(0, imageOffsetY, AccessoryFontSize, AccessoryFontSize);
    }
    return UpdatedAtAttachment;
}

static NSAttributedString *UpdatedAtIconAttributedString = nil;
+ (NSAttributedString *)updatedAtIconAttributedString {
    if (UpdatedAtIconAttributedString == nil) {
        UpdatedAtIconAttributedString = [NSAttributedString attributedStringWithAttachment:[self updatedAtAttachment]];
    }
    return UpdatedAtIconAttributedString;
}

#pragma mark - Accessors

- (UIView *)container {
    if (_container == nil) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = UIColor.whiteColor;
    }
    return _container;
}

- (UIView *)accessoriesContainer {
    if (_accessoriesContainer == nil) {
        _accessoriesContainer = [[UIView alloc] init];
        _accessoriesContainer.backgroundColor = UIColor.whiteColor;
    }
    return _accessoriesContainer;
}

- (void)setItem:(NSString *)item {
    _item = item;
    self.lbItem.text = _item;
}

- (void)setPronunciation:(NSString *)pronunciation {
    _pronunciation = pronunciation;
    self.lbDetailA.text = _pronunciation;
}

- (void)setMeaning:(NSString *)meaning {
    _meaning = meaning;
    self.lbDetailB.text = _meaning;
}

- (void)setUpdateAt:(NSString *)updateAt {
    _updateAt = updateAt;
    // 文字部分
    NSAttributedString *attributedStringContent = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", _updateAt] attributes:[[self class] accessoryAttributes]];
    // 图标部分
    NSMutableAttributedString *combinedAttributedString = [[NSAttributedString attributedStringWithAttachment:[[self class] updatedAtAttachment]] mutableCopy];
    [combinedAttributedString appendAttributedString:attributedStringContent];
    self.lbUpdateAt.attributedText = [combinedAttributedString copy];
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

- (UILabel *)lbUpdateAt {
    if (_lbUpdateAt == nil) {
        _lbUpdateAt = [[UILabel alloc] init];
        _lbUpdateAt.numberOfLines = 1;
    }
    return _lbUpdateAt;
}

@end
