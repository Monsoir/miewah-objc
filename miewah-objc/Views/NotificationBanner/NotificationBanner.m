//
//  NotificationBanner.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "NotificationBanner.h"
#import "UIConstants.h"

#import "UIView+Nib.h"

static const CGFloat BarHeight = 80;

struct BannerPositionFrame {
    CGRect startPosition;
    CGRect endPosition;
};

typedef struct BannerPositionFrame BannerPositionFrame;

@protocol BannerColorsProtocol
+ (UIColor *)colorForStyle:(BannerStyle)style;
@end

static UIColor *colorForStyle(BannerStyle style) {
    switch (style) {
        case BannerStyleDanger: return [UIColor colorWithRed:0.90 green:0.31 blue:0.26 alpha:1];
        case BannerStyleInfo: return [UIColor colorWithRed:0.23 green:0.6 blue:0.85 alpha:1];
        case BannerStyleNone: return UIColor.clearColor;
        case BannerStyleSuccess: return [UIColor colorWithRed:0.22 green:0.80 blue:0.46 alpha:1];
        case BannerStyleWarning: return [UIColor colorWithRed:1 green:0.66 blue:0.16 alpha:1];
    }
}

BannerPositionFrame BannerPositionMake(CGFloat width, CGFloat height) {
    BannerPositionFrame frame;
    CGRect startPosition = CGRectMake(0, -height, width, height);
    CGRect endPosition = CGRectMake(0, 0, width, height);
    frame.startPosition = startPosition;
    frame.endPosition = endPosition;
    return frame;
}

@interface NotificationBanner()
@property (nonatomic, weak) IBOutlet UILabel *lbTitle;
@property (nonatomic, weak) IBOutlet UILabel *lbDetail;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesgure;
@property (nonatomic, strong) UISwipeGestureRecognizer *swiptGesture;

@property (nonatomic, assign) BannerPositionFrame bannerPositionFrame;
@end

@implementation NotificationBanner

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromNib];
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadViewFromNib];
        [self initialize];
    }
    return self;
}

- (instancetype)initWithStyle:(BannerStyle)style {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self loadViewFromNib];
        [self initialize];
        self.bannerStyle = style;
    }
    return self;
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", NSStringFromClass([self class]));
#endif
}

- (void)initialize {
    self.duration = 2.0;
    self.autoDismiss = YES;
    self.isDisplaying = NO;
    self.bannerStyle = BannerStyleNone;
}

- (void)showOnViewController:(UIViewController *)viewController {
    if (viewController != nil) {
        self.parentController = viewController;
        [self.parentController.view addSubview:self];
    } else {
        [[self appWindow] addSubview:self];
    }
    
    [self contentView].backgroundColor = colorForStyle(self.bannerStyle);
    self.bannerPositionFrame = [self bannerPositionFrameForViewController:viewController];
    [self correctTitleTopMargin];
    
    self.frame = self.bannerPositionFrame.startPosition;
    [UIView animateWithDuration:1.0 animations:^{
        self.frame = self.bannerPositionFrame.endPosition;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isDisplaying = YES;
            [self.tapGesgure addTarget:self action:@selector(dismiss)];
            [self addGestureRecognizer:self.tapGesgure];
            [self.swiptGesture addTarget:self action:@selector(dismiss)];
            [self addGestureRecognizer:self.swiptGesture];
            if (self.autoDismiss) {
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
            }
        }
    }];
}

- (void)dismiss {
    if (self.isDisplaying == NO) return;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.frame = self.bannerPositionFrame.startPosition;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isDisplaying = NO;
            [self removeFromSuperview];
        }
    }];
}

- (BannerPositionFrame)bannerPositionFrameForViewController:(UIViewController *)vc {
    CGFloat height = BarHeight;
    height = BarHeight + ([UIConstants isiPhoneX] ? 40 : 20);
    return BannerPositionMake(UIScreen.mainScreen.bounds.size.width, height);
}

- (void)correctTitleTopMargin {
    if (self.parentController == nil) {
        self.lbTitleTopConstraint.constant = [UIConstants isiPhoneX] ? 40 : 20;
        [self setNeedsUpdateConstraints];
    }
}

+ (void)displayABannerWithTitle:(NSString *)title detail:(NSString *)detail style:(BannerStyle)style onViewController:(UIViewController *)vc {
    NotificationBanner *banner = [[NotificationBanner alloc] init];
    banner.titleForegroundColor = UIColor.whiteColor;
    banner.detailForegroundColor = UIColor.whiteColor;
    banner.bannerStyle = style;
    banner.title = title;
    banner.detail = detail;
    [banner showOnViewController:vc];
}

- (UIWindow *)appWindow {
    return [UIApplication sharedApplication].delegate.window;
}

- (UITapGestureRecognizer *)tapGesgure {
    if (!_tapGesgure) {
        _tapGesgure = [[UITapGestureRecognizer alloc] init];
    }
    
    return _tapGesgure;
}

- (UISwipeGestureRecognizer *)swiptGesture {
    if (!_swiptGesture) {
        _swiptGesture = [[UISwipeGestureRecognizer alloc] init];
        _swiptGesture.direction = UISwipeGestureRecognizerDirectionUp;
    }
    
    return _swiptGesture;
}

- (UIView *)contentView {
    return self.lbTitle.superview;
}

@synthesize titleForegroundColor = _titleForegroundColor;
- (UIColor *)titleForegroundColor {
    return self.lbTitle.textColor;
}

- (void)setTitleForegroundColor:(UIColor *)color {
    self.lbTitle.textColor = color;
}

@synthesize detailForegroundColor = _detailForegroundColor;
- (UIColor *)detailForegroundColor {
    return self.lbDetail.textColor;
}

- (void)setDetailForegroundColor:(UIColor *)color {
    self.lbDetail.textColor = color;
}

@synthesize title = _title;
- (NSString *)title {
    return self.lbTitle.text;
}

- (void)setTitle:(NSString *)title {
    self.lbTitle.text = title;
}

@synthesize detail = _detail;
- (NSString *)detail {
    return self.lbDetail.text;
}

- (void)setDetail:(NSString *)detail {
    self.lbDetail.text = detail;
}

@end
