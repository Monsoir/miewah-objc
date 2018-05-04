//
//  SlangDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangDetailViewModel.h"
#import "MiewahSlangRequesterManager.h"
#import "SlangDetailResponseObject.h"
#import "MiewahRequestProtocol.h"

@interface SlangDetailViewModel ()

@property (nonatomic, strong) MiewahSlang *slang;
@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) NSArray<NSString *> *displayContents;
@property (nonatomic, strong) id<MiewahDetailRequestProtocol> requester;

@end

@implementation SlangDetailViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    self.requestSuccessHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        SlangDetailResponseObject *_payload = (SlangDetailResponseObject *)payload;
        MiewahSlang *slang = [[MiewahSlang alloc] initWithDictionary:_payload.slang];
        self.slang = slang; // 这是设置好对象罢了
        self.displayContents = [self makeContentToDisplay]; // 这是将需要展示的数据整理成数组形式，让 controller 更好地读取
        [self.loadedSuccess sendNext:slang];
    };
}

- (NSArray <NSString *> *)makeContentToDisplay {
    return @[
             self.slang.meaning ?: @"", // 意义
             @"", // 出处参考
             self.slang.sentences ?: @"", // 例句
             @"", //输入法
             ];
}

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SlangDetailSections" ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

@synthesize requester = _requester;
- (id<MiewahDetailRequestProtocol>)requester {
    if (_requester == nil) {
        _requester = [[MiewahSlangRequesterManager alloc] init];
    }
    return _requester;
}

@end
