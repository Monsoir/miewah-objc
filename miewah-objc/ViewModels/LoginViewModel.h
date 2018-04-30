//
//  LoginViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"

@interface LoginViewModel : MiewahViewModel

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong, readonly) RACSignal *validEmailSignal;
@property (nonatomic, strong, readonly) RACSignal *validPasswordSignal;
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACSubject *loginSuccess;
@property (nonatomic, strong, readonly) RACSubject *loginFailure;
@property (nonatomic, strong, readonly) RACSubject *loginError;

- (BOOL)checkEmailValid:(NSString *)email;
- (BOOL)checkPasswordValid:(NSString *)password;

- (void)postLogin;

@end
