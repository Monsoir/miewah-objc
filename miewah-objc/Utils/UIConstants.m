//
//  Constants.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/26.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIConstants.h"

CGFloat const iPhoneXDeviceHeight = 2436;

@implementation UIConstants

+ (CGFloat)NavigationBarHeight {
    return [[self class] isiPhoneX] ? 88 : 64;
}

+ (BOOL)isiPhoneX {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return false;
    }
    
    return UIScreen.mainScreen.nativeBounds.size.height == iPhoneXDeviceHeight;
}

@end
