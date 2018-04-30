//
//  MiewahRegisterManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahRegisterManager.h"
#import "MiewahAPIManager.h"
#import "RegisterResponseObject.h"

@interface MiewahRegisterManager ()

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *confirmedPassword;

@end

@implementation MiewahRegisterManager

- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password confirmedPassword:(NSString *)confirmedPassword {
    self = [super init];
    if (self) {
        _email = email;
        _password = password;
        _confirmedPassword = confirmedPassword;
    }
    return self;
}

- (NSURLSessionDataTask *)postRegistrationSuccess:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    NSDictionary *params = @{@"email": self.email,
                             @"password": self.password,
                             @"confirmPassword": self.confirmedPassword,
                             };
    return [worker POST:[[MiewahAPIManager sharedManager] registerURL] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RegisterResponseObject *payload = [[RegisterResponseObject alloc] initWithDictionary:responseObject];
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
