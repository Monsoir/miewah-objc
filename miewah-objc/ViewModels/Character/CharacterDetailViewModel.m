//
//  WordDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterDetailViewModel.h"
#import "CharacterService.h"
#import "MiewahCharacter.h"

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
             alwaysString([self prettifiedInputMethod]), // 输入法
             @"", // 查询关键词
             ];
}

- (NSString *)prettifiedInputMethod {
    MiewahCharacter *item = (MiewahCharacter *)self.asset;
    NSDictionary *methods = [item organizedInputMethods];
    if (methods == nil) return nil;
    
    NSMutableString *presentation = [NSMutableString string];
    NSMutableString *temp = [NSMutableString string];
    [methods enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray * _Nonnull obj, BOOL * _Nonnull stop) {
        [temp setString:@""];
        for (InputMethod *method in obj) {
            [temp appendFormat:@"\t%@: %@\n", method.inputMethodName, method.input];
        }
        [presentation appendString:key];
        [presentation appendFormat:@"\n%@", [temp copy]];
    }];
    
    return [presentation copy];
}

#pragma mark - Accessors

@synthesize sectionNames = _sectionNames;
- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CharacterDetailSections" ofType:@"plist"];
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
