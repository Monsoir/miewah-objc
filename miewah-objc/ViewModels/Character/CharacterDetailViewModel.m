//
//  WordDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterDetailViewModel.h"
#import "CharacterService.h"

@interface CharacterDetailViewModel ()

@property (nonatomic, strong) CharacterService *service;
@property (nonatomic, strong) NSArray<NSString *> *sectionNames;

@end

@implementation CharacterDetailViewModel

- (NSArray <NSString *> *)makeContentToDisplay {
    MiewahCharacter *asset = (MiewahCharacter *)self.asset;
    return @[
             alwaysString(asset.meaning), // 意义
             alwaysString(asset.source), // 出处参考
             alwaysString(asset.sentences), // 例句
#warning 后台需要修改一下输入法数据的格式
//             alwaysString(asset.prettifiedInputMethods), //输入法
             alwaysString(asset.inputMethods), //输入法
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
- (CharacterService *)service {
    if (_service == nil) {
        _service = [[CharacterService alloc] init];
    }
    return _service;
}

@end
