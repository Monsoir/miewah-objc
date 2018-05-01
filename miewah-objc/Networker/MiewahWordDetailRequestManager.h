//
//  MiewahWordDetailRequestManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"

@interface MiewahWordDetailRequestManager : NSObject

- (NSURLSessionDataTask *)getWordDetail:(NSString *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
