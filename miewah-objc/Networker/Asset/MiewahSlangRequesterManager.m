//
//  MiewahSlangRequesterManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahSlangRequesterManager.h"
#import "MiewahAPIManager.h"
#import "MiewahUser.h"

@implementation MiewahSlangRequesterManager

- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    return [worker GET:[[MiewahAPIManager sharedManager] slangsURLWithPageIndex:pageIndex]
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   BaseResponseObject *payload = [BaseResponseObject responseObjectOfType:ResponseObjectTypeSlangList configuredWithDict:responseObject];
                   [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   errorHandler(error);
               }];
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSNumber *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    NSString *url = [[MiewahAPIManager sharedManager] slangDetailOfIdentifier:identifier];
    return [worker GET:url
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   BaseResponseObject *payload = [BaseResponseObject responseObjectOfType:ResponseObejctTypeSlangDetail configuredWithDict:responseObject];
                   [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   errorHandler(error);
               }];
}

- (NSURLSessionDataTask *)postNewAsset:(NSDictionary *)asset success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"jwt %@", ThisUser.loginToken]};
    NSString *url = [SharedAPIManager newSlang];
    
    return [self.requester postToURL:url
                              params:asset
                             headers:headers
                             success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                 BaseResponseObject *payload = [BaseResponseObject responseObjectOfType:ResponseObjectTypeNewCharacter configuredWithDict:responseObject];
                                 [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                                 errorHandler(error);
                             }];
}

@end
