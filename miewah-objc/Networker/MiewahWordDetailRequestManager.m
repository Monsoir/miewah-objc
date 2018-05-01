//
//  MiewahWordDetailRequestManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahWordDetailRequestManager.h"
#import "WordDetailResponseObject.h"
#import "MiewahAPIManager.h"

@implementation MiewahWordDetailRequestManager

- (NSURLSessionDataTask *)getWordDetail:(NSString *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    return [worker GET:[[MiewahAPIManager sharedManager] wordDetailOfIdentifier:identifier]
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   WordDetailResponseObject *payload = [[WordDetailResponseObject alloc] initWithDictionary:responseObject];
                   [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   errorHandler(error);
               }];
}

@end
