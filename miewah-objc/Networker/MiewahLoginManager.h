//
//  MiewahLoginManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"

@interface MiewahLoginManager : NSObject

- (NSURLSessionDataTask *)postLoginWithIdentifier:(NSString *)identifier password:(NSString *)password success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
