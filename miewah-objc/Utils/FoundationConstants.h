//
//  FoundationConstants.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger MiewahPasswordLength;
extern NSString * const LoginCompleteNotificationName;

#define StandardUserDefault [NSUserDefaults standardUserDefaults]

typedef enum : NSUInteger {
    MiewahItemTypeCharacter,
    MiewahItemTypeWord,
    MiewahItemTypeSlang,
    MiewahItemTypeNone,
} MiewahItemType;

@interface FoundationConstants : NSObject

@end
