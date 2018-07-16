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
//#define runOnMainThread(aBlock) \
//if ([NSThread isMainThread]) { \
//aBlock(); \
//} else { \
//dispatch_async(dispatch_get_main_queue(), ^{ \
//aBlock(); \
//}); \
//}

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef runOnMainThread
#define runOnMainThread(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

#ifndef MainStoryBoard
#define MainStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#endif

@interface UIConstants : NSObject

+ (CGFloat)NavigationBarHeight;
+ (BOOL)isiPhoneX;
+ (CGFloat)screenWidth;

@end
