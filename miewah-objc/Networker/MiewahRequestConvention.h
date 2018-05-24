//
//  MiewahRequestConvention.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/24.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseObject.h"

typedef void (^MiewahRequestSuccess)(BaseResponseObject *payload);
typedef void (^MiewahRequestFailure)(BaseResponseObject *payload);
typedef void (^MiewahRequestError)(NSError *error);

extern NSString * const MiewahRequestErrorCodeKey;
extern NSString * const MiewahRequestErrorMessageKey;

typedef enum : NSUInteger {
    MiewahRequestErrorCodeUnauthorized,
    MiewahRequestErrorCodeUnknown,
} MiewahRequestErrorCode;

@interface MiewahRequestConvention : NSObject

@end
