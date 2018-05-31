 //
//  LoginViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LoginViewModel.h"
#import "MiewahLoginManager.h"
#import "Validator.h"
#import "FoundationConstants.h"

@interface LoginViewModel()
@property (nonatomic, strong) RACSignal *validEmailSignal;
@property (nonatomic, strong) RACSignal *validPasswordSignal;
@property (nonatomic, strong) RACSignal *enableLoginSignal;

@property (nonatomic, strong) RACSubject *loginSuccess;
@property (nonatomic, strong) RACSubject *loginFailure;
@property (nonatomic, strong) RACSubject *loginError;

@property (nonatomic, strong) MiewahLoginManager *loginManager;

@end

@implementation LoginViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    
    self.validEmailSignal = [RACObserve(self, email) map:^id _Nullable(id  _Nullable value) {
        @strongify(self);
        return @([self checkEmailValid:value]);
    }];
    
    self.validPasswordSignal = [RACObserve(self, password) map:^id _Nullable(id  _Nullable value) {
        @strongify(self);
        return @([self checkPasswordValid:value]);
    }];
    
    NSArray<RACSignal *> *signals = @[self.validEmailSignal, self.validPasswordSignal];
    self.enableLoginSignal = [RACSignal combineLatest:signals reduce:^id _Nonnull (NSNumber *validEmail, NSNumber *validPassword){
        return @([validEmail boolValue] && [validPassword boolValue]);
    }];
}

- (void)dealloc {
    [self.loginSuccess sendCompleted];
    [self.loginFailure sendCompleted];
    [self.loginError sendCompleted];
}

- (BOOL)checkEmailValid:(NSString *)email {
    return [Validator validateEmail:email];
}

- (BOOL)checkPasswordValid:(NSString *)password {
    return [Validator validateString:password length:MiewahPasswordLength];
}

- (void)postLogin {
    @weakify(self);
    MiewahRequestSuccess successHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        [self.loginSuccess sendNext:payload];
        [self.loginSuccess sendCompleted];
    };
    MiewahRequestFailure failureHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        [self.loginFailure sendNext:payload.comments];
    };
    MiewahRequestError errorHandler = ^(NSError *error) {
        @strongify(self);
        [self.loginError sendNext:error];
    };
    [self.loginManager postLoginWithIdentifier:self.email
                                      password:self.password
                                       success:successHandler
                                       failure:failureHandler
                                         error:errorHandler];
}

- (MiewahLoginManager *)loginManager {
    if (_loginManager == nil) {
        _loginManager = [[MiewahLoginManager alloc] init];
    }
    return _loginManager;
}

- (RACSubject *)loginSuccess {
    if (_loginSuccess == nil) {
        _loginSuccess = [[RACSubject alloc] init];
    }
    return _loginSuccess;
}

- (RACSubject *)loginFailure {
    if (_loginFailure == nil) {
        _loginFailure = [[RACSubject alloc] init];
    }
    return _loginFailure;
}

- (RACSubject *)loginError {
    if (_loginError == nil) {
        _loginError = [[RACSubject alloc] init];
    }
    return _loginError;
}
@end
