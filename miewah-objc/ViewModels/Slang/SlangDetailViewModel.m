//
//  SlangDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangDetailViewModel.h"
#import "SlangService.h"

@interface SlangDetailViewModel ()

@property (nonatomic, strong) SlangService *service;
@property (nonatomic, strong) NSArray<NSString *> *sectionNames;

@end

@implementation SlangDetailViewModel

- (NSArray <NSString *> *)makeContentToDisplay {
    MiewahSlang *asset = (MiewahSlang *)self.asset;
    return @[
             alwaysString(asset.meaning), // 意义
             alwaysString(asset.meaning), // 出处参考
             alwaysString(asset.sentences), // 例句
             ];
}

@synthesize sectionNames = _sectionNames;
- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SlangDetailSections" ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

@synthesize service = _service;
- (SlangService *)service {
    if (_service == nil) {
        _service = [[SlangService alloc] init];
    }
    return _service;
}

@end
