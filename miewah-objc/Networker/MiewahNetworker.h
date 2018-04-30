//
//  MiewahNetworker.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseObject.h"

@import AFNetworking;

typedef void (^MiewahRequestSuccess)(BaseResponseObject *payload);
typedef void (^MiewahRequestFailure)(BaseResponseObject *payload);
typedef void (^MiewahRequestError)(NSError *);

@interface MiewahNetworker : AFHTTPSessionManager

+ (instancetype)sharedNetworker;

@end
