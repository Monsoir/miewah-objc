//
//  RegisterViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "RegisterViewModel.h"
#import "MiewahRegisterManager.h"
#import "Validator.h"
#import "FoundationConstants.h"

@interface RegisterViewModel ()

@property (nonatomic, strong) RACSignal *validEmailSignal;
@property (nonatomic, strong) RACSignal *validPasswordSignal;
@property (nonatomic, strong) RACSignal *validPasswordConfirmationSignal;
@property (nonatomic, strong) RACSignal *enableRegisterSignal;

@property (nonatomic, strong) RACSubject *registerSuccess;
@property (nonatomic, strong) RACSubject *registerFailure;
@property (nonatomic, strong) RACSubject *registerError;

@property (nonatomic, strong) MiewahRegisterManager *registerManager;

@end

@implementation RegisterViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    
    self.validEmailSignal = [RACObserve(self, email) map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        return @([self checkEmailValid:value]);
    }];
    
    self.validPasswordSignal = [RACObserve(self, password) map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        return @([self checkPasswordValid:value]);
    }];
    
    self.validPasswordConfirmationSignal = [RACObserve(self, passwordConfirmation) map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        return @([self checkPasswordConfirmationValid:value]);
    }];
    
    NSArray<RACSignal *> *signals = @[self.validEmailSignal, self.validPasswordSignal, self.validPasswordConfirmationSignal];
    self.enableRegisterSignal = [RACSignal combineLatest:signals reduce:^id _Nonnull (NSNumber *validUserName, NSNumber *validPassword, NSNumber *validPasswordConfirmation) {
        return @([validUserName boolValue] && [validPassword boolValue] && [validPasswordConfirmation boolValue]);
    }];
}

- (void)postRegister {
    self.registerManager = [[MiewahRegisterManager alloc] initWithEmail:self.email password:self.password confirmedPassword:self.passwordConfirmation];
    @weakify(self);
    MiewahRequestSuccess successHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        [self.registerSuccess sendNext:payload.comments];
        [self.registerSuccess sendCompleted];
    };
    MiewahRequestFailure failureHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        [self.registerFailure sendNext:payload.comments];
    };
    MiewahRequestError errorHandler = ^(NSError *error) {
        @strongify(self);
        [self.registerError sendNext:error];
    };
    [self.registerManager postRegistrationSuccess:successHandler failure:failureHandler error:errorHandler];
}

- (BOOL)checkEmailValid:(NSString *)email {
    return [Validator validateEmail:email];
}

- (BOOL)checkPasswordValid:(NSString *)password {
    return [Validator validateString:password length:MiewahPasswordLength];
}

- (BOOL)checkPasswordConfirmationValid:(NSString *)password {
    return (password.length > 0) && [password isEqualToString:self.password];
}

- (RACSubject *)registerSuccess {
    if (_registerSuccess == nil) {
        _registerSuccess = [[RACSubject alloc] init];
    }
    return _registerSuccess;
}

- (RACSubject *)registerFailure {
    if (_registerFailure == nil) {
        _registerFailure = [[RACSubject alloc] init];
    }
    return _registerFailure;
}

- (RACSubject *)registerError {
    if (_registerError == nil) {
        _registerError = [[RACSubject alloc] init];
    }
    return _registerError;
}

@end
