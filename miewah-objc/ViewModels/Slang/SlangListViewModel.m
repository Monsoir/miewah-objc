//
//  SlangListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangListViewModel.h"
#import "SlangService.h"

@interface SlangListViewModel()

@property (nonatomic, strong) SlangService *service;

@end

@implementation SlangListViewModel

+ (MiewahItemType)assetType {
    return MiewahItemTypeSlang;
}

#pragma mark - Accessors
@synthesize service = _service;
- (SlangService *)service {
    if (_service == nil) {
        _service = [[SlangService alloc] init];
    }
    return _service;
}

@end
