//
//  MiewahCharacterRequestManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"

@interface MiewahCharacterRequestManager : NSObject

- (NSURLSessionDataTask *)getCharactersAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
