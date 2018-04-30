//
//  MiewahRegisterManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"

@interface MiewahRegisterManager : NSObject

- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password confirmedPassword:(NSString *)confirmedPassword;
- (NSURLSessionDataTask *)postRegistrationSuccess:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
