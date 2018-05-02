//
//  MiewahWordRequestManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahWordRequestManager.h"
#import "MiewahAPIManager.h"
#import "BaseResponseObject.h"

@implementation MiewahWordRequestManager

- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    return [worker GET:[[MiewahAPIManager sharedManager] wordsURLWithPageIndex:pageIndex]
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   BaseResponseObject *payload = [BaseResponseObject responseObjectOfType:ResponseObjectTypeWordList configuredWithDict:responseObject];
                   [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   errorHandler(error);
               }];
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSNumber *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    NSString *url = [[MiewahAPIManager sharedManager] wordDetailOfIdentifier:identifier];
    return [worker GET:url
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   BaseResponseObject *payload = [BaseResponseObject responseObjectOfType:ResponseObjectTypeWordDetail configuredWithDict:responseObject];
                   [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   errorHandler(error);
               }];
}

@end
