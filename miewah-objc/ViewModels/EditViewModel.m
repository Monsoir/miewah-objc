//
//  EditViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditViewModel.h"

@implementation EditViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.ItemTypeSignal = [RACObserve(self, itemType) map:^id _Nullable(NSNumber * _Nullable value) {
        return value;
    }];
}

@end
