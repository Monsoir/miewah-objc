//
//  WordDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordDetailViewModel.h"
#import "WordService.h"

@interface WordDetailViewModel ()

@property (nonatomic, strong) WordService *service;
@property (nonatomic, strong) NSArray<NSString *> *sectionNames;

@end

@implementation WordDetailViewModel

- (NSArray <NSString *> *)makeContentToDisplay {
    MiewahWord *asset = (MiewahWord *)self.asset;
    return @[
             alwaysString(asset.meaning), // 意义
             alwaysString(asset.source), // 出处参考
             alwaysString(asset.sentences), // 例句
             @"",
             @"", // 搜索关键字
             ];
}

#pragma mark - Accessors

@synthesize sectionNames = _sectionNames;
- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WordDetailSections" ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

@synthesize service = _service;
- (WordService *)service {
    if (_service == nil) {
        _service = [[WordService alloc] init];
    }
    return _service;
}

@end
