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

- (void)loadDetail {
    if (self.identifier == nil) {
#if DEBUG
        NSLog(@"%@'s identifier is nil", [self class]);
#endif
        return;
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
