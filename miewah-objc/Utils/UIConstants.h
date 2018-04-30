//
//  Constants.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/26.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat iPhoneXDeviceHeight;


/**
 确保在主线程中运行
 */
#define runOnMainThread(aBlock) \
if ([NSThread isMainThread]) { \
aBlock(); \
} else { \
dispatch_async(dispatch_get_main_queue(), ^{ \
aBlock(); \
}); \
}

@interface UIConstants : NSObject

+ (CGFloat)NavigationBarHeight;
+ (BOOL)isiPhoneX;

@end
