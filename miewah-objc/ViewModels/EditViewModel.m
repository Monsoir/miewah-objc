//
//  EditViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditViewModel.h"

@interface EditViewModel()

@property (nonatomic, strong) RACSignal *itemTypeSignal;

@end

@implementation EditViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.itemTypeSignal = [RACObserve(self, itemType) map:^id _Nullable(NSNumber * _Nullable value) {
        return value;
    }];
}

@end
