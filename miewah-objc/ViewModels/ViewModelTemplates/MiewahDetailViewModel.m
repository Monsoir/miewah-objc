//
//  MiewahDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahDetailViewModel.h"

@interface MiewahDetailViewModel ()

@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;
@property (nonatomic, strong) RACSubject *loadedError;

@end

@implementation MiewahDetailViewModel

- (instancetype)initWithIdentifier:(NSNumber *)identifier {
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    return self;
}

- (void)dealloc {
    [self.loadedSuccess sendCompleted];
    [self.loadedFailure sendCompleted];
    [self.loadedError sendCompleted];
}

- (void)loadDetail {
    if (self.identifier == nil) {
#if DEBUG
        NSLog(@"%@'s identifier is nil", [self class]);
#endif
        return;
    }
    
    @weakify(self);
    if (_requestFailureHandler == nil) {
        _requestFailureHandler = ^(BaseResponseObject *payload) {
            @strongify(self);
            [self.loadedFailure sendNext:[payload.comments componentsJoinedByString:@", "]];
        };
    }
    
    if (_requestErrorHandler == nil) {
        _requestErrorHandler = ^(NSError *error) {
            @strongify(self);
            [self.loadedError sendNext:error];
        };
    }
    
    [self.requester getDetailOfIdentifier:self.identifier
                                  success:self.requestSuccessHandler
                                  failure:self.requestFailureHandler
                                    error:self.requestErrorHandler];
}

- (RACSubject *)loadedSuccess {
    if (_loadedSuccess == nil) {
        _loadedSuccess = [[RACSubject alloc] init];
    }
    return _loadedSuccess;
}

- (RACSubject *)loadedFailure {
    if (_loadedFailure == nil) {
        _loadedFailure = [[RACSubject alloc] init];
    }
    return _loadedFailure;
}

- (RACSubject *)loadedError {
    if (_loadedError == nil) {
        _loadedError = [[RACSubject alloc] init];
    }
    return _loadedError;
}

@end
