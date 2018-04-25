//
//  NotificationBanner.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BannerStyleDanger,
    BannerStyleInfo,
    BannerStyleNone,
    BannerStyleSuccess,
    BannerStyleWarning,
} BannerStyle;

@interface NotificationBanner : UIView

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lbTitleTopConstraint;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL autoDismiss;
@property (nonatomic, assign) BOOL isDisplaying;
@property (nonatomic, weak) UIViewController *parentController;

@property (nonatomic, assign) BannerStyle bannerStyle;

@end
