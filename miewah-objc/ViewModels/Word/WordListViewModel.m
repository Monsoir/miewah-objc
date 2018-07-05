//
//  WordListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordListViewModel.h"
#import "WordService.h"

@interface WordListViewModel()

@property (nonatomic, strong) WordService *service;

@end

@implementation WordListViewModel

+ (MiewahItemType)assetType {
    return MiewahItemTypeWord;
}

#pragma mark - Accessors

@synthesize service = _service;
- (WordService *)service {
    if (_service == nil) {
        _service = [[WordService alloc] init];
    }
    return _service;
}

@end
