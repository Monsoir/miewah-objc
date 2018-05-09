//
//  WordDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterDetailViewModel.h"
#import "CharacterDetailResponseObject.h"
#import "MiewahCharacterRequestManager.h"

@interface CharacterDetailViewModel ()

@property (nonatomic, strong) MiewahCharacter *character;
@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) NSArray<NSString *> *displayContents;

@property (nonatomic, strong) id<MiewahDetailRequestProtocol> requester;

@end

@implementation CharacterDetailViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    self.requestSuccessHandler = ^(BaseResponseObject *payload){
        @strongify(self);
        CharacterDetailResponseObject *_payload = (CharacterDetailResponseObject *)payload;
        MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:_payload.character];
        self.character = character; // 这是设置好对象罢了
        self.displayContents = [self makeContentToDisplay]; // 这是将需要展示的数据整理成数组形式，让 controller 更好地读取
        [self.loadedSuccess sendNext:character];
    };
}

- (NSArray <NSString *> *)makeContentToDisplay {
    return @[
             self.character.meaning ?: @"", // 意义
             @"", // 出处参考
             self.character.sentences ?: @"", // 例句
             self.character.prettifiedInputMethods ?: @"", //输入法
             @"", // 搜索关键字
             ];
}

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WordDetailSections" ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

@synthesize requester = _requester;
- (id<MiewahDetailRequestProtocol>)requester {
    if (_requester == nil) {
        _requester = [[MiewahCharacterRequestManager alloc] init];
    }
    return _requester;
}

@end
