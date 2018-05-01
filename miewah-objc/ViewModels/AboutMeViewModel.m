//
//  AboutMeViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AboutMeViewModel.h"
#import "FoundationConstants.h"
#import "MiewahUser.h"

@interface AboutMeViewModel ()

@property (nonatomic, strong) NSNumber *logged;
@property (nonatomic, strong) NSArray<NSString *> *interactiveItems;

@property (nonatomic, strong) RACSignal *loggedChangedSignal;
@property (nonatomic, strong) id loggedObserver;

@property (nonatomic, strong) NSArray<NSString *> *loggeditems;
@property (nonatomic, strong) NSArray<NSString *> *unloggedItems;

@end

@implementation AboutMeViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    MiewahUser *thisUser = [MiewahUser thisUser];
    self.loggedChangedSignal = [RACObserve(thisUser, loginToken) map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        BOOL logged = value.length != 0;
        NSNumber *boolO = @(logged);
        self.logged = boolO;
        self.interactiveItems = logged ? self.loggeditems : self.unloggedItems;
        return boolO;
    }];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self.loggedObserver name:LoginCompleteNotificationName object:nil];
}

- (NSArray<NSString *> *)loggeditems {
    if (_loggeditems == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AboutMeLoggedItems" ofType:@"plist"];
        _loggeditems = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _loggeditems;
}

- (NSArray<NSString *> *)unloggedItems {
    if (_unloggedItems == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AboutMeUnloggedItems" ofType:@"plist"];
        _unloggedItems = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _unloggedItems;
}

@end
