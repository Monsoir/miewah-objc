//
//  MiewahLoginManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahLoginManager.h"
#import "MiewahAPIManager.h"
#import "LoginResponseObject.h"

@interface MiewahLoginManager ()

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *password;

@end

@implementation MiewahLoginManager

- (NSURLSessionDataTask *)postLoginWithIdentifier:(NSString *)identifier password:(NSString *)password success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    NSDictionary *params = @{@"email": identifier,
                             @"password": password,
                             };
    return [worker POST:[[MiewahAPIManager sharedManager] loginURL] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LoginResponseObject *payload = [[LoginResponseObject alloc] initWithDictionary:responseObject];
        if ([payload.success boolValue]) {
            successHandler(payload);
        } else {
            failureHandler(payload);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorHandler(error);
    }];
}

@end
