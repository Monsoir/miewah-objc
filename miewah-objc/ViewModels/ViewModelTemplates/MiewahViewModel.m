//
//  MiewahViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"

@implementation MiewahViewModel

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", [self class]);
#endif
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeObserverSignals];
    }
    return self;
}

- (void)initializeObserverSignals {
    
}

@end
