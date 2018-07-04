//
//  CharacterListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterListViewModel.h"
#import "CharacterService.h"

@interface CharacterListViewModel()

@property (nonatomic, strong) CharacterService *service;

@end

@implementation CharacterListViewModel

- (void)readCache {
    
}

#pragma mark - Accessors

@synthesize service = _service;
- (CharacterService *)service {
    if (_service == nil) {
        _service = [[CharacterService alloc] init];
    }
    return _service;
}

@end
