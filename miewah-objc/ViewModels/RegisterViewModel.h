//
//  RegisterViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"

@interface RegisterViewModel : MiewahViewModel

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *passwordConfirmation;

@property (nonatomic, strong, readonly) RACSignal *validEmailSignal;
@property (nonatomic, strong, readonly) RACSignal *validPasswordSignal;
@property (nonatomic, strong, readonly) RACSignal *validPasswordConfirmationSignal;
@property (nonatomic, strong, readonly) RACSignal *enableRegisterSignal;

@property (nonatomic, strong, readonly) RACSubject *registerSuccess;
@property (nonatomic, strong, readonly) RACSubject *registerFailure;
@property (nonatomic, strong, readonly) RACSubject *registerError;

- (void)postRegister;

@end
