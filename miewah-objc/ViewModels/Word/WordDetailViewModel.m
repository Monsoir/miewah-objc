//
//  WordDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordDetailViewModel.h"
#import "MiewahWordRequestManager.h"
#import "WordDetailResponseObject.h"

@interface WordDetailViewModel ()

@property (nonatomic, strong) MiewahWord *word;
@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) NSArray<NSString *> *displayContents;
@property (nonatomic, strong) id<MiewahDetailRequestProtocol> requester;

@end

@implementation WordDetailViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    self.requestSuccessHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        WordDetailResponseObject *_payload = (WordDetailResponseObject *)payload;
        MiewahWord *word = [[MiewahWord alloc] initWithDictionary:_payload.word];
        self.word = word; // 这是设置好对象罢了
        self.displayContents = [self makeContentToDisplay]; // 这是将需要展示的数据整理成数组形式，让 controller 更好地读取
        [self.loadedSuccess sendNext:word];
    };
}

- (NSArray <NSString *> *)makeContentToDisplay {
    return @[
             self.word.meaning ?: @"", // 意义
             @"", // 出处参考
             self.word.sentences ?: @"", // 例句
             @"", //输入法
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
        _requester = [[MiewahWordRequestManager alloc] init];
    }
    return _requester;
}

@end
