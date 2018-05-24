//
//  EditViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditViewModel.h"
#import "NewMiewahAsset.h"

@interface EditViewModel()

@property (nonatomic, strong) RACSignal *itemTypeSignal;

@end

@implementation EditViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemType = @(MiewahItemTypeCharacter);
    }
    return self;
}

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.itemTypeSignal = [RACObserve(self, itemType) map:^id _Nullable(NSNumber * _Nullable value) {
        return value;
    }];
    
    [self.itemTypeSignal subscribeNext:^(id  _Nullable x) {
        // 改变实例
        MiewahItemType type = [x unsignedIntegerValue];
        [NewMiewahAsset sharedAsset].type = type;
    }];
}

- (void)dealloc {
    [NewMiewahAsset sharedAsset].type = MiewahItemTypeNone;
}

@end
