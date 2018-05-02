//
//  WordDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordDetailViewModel.h"
#import "MiewahWordDetailRequestManager.h"
#import "WordDetailResponseObject.h"

@interface WordDetailViewModel ()

@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) NSArray<NSString *> *displayContents;
@property (nonatomic, strong) MiewahCharacter *characterDetail;

@property (nonatomic, strong) RACSubject *detailRequestSuccess;
@property (nonatomic, strong) RACSubject *detailRequestFailure;
@property (nonatomic, strong) RACSubject *detailRequestError;

@property (nonatomic, strong) MiewahWordDetailRequestManager *requester;

@end

@implementation WordDetailViewModel

- (instancetype)initWithWordIdentifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    return self;
}

- (void)loadWordDetail {

    if (!self.identifier) {
#if DEBUG
        NSLog(@"%@'s identifier is nil", [self class]);
#endif
        return;
    }
    
    @weakify(self);
    MiewahRequestSuccess successHandler = ^(BaseResponseObject *payload){
        @strongify(self);
        WordDetailResponseObject *_payload = (WordDetailResponseObject *)payload;
        MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:_payload.character];
        self.characterDetail = character; // 这是设置好对象罢了
        self.displayContents = [self makeContentToDisplay]; // 这是将需要展示的数据整理成数组形式，让 controller 更好地读取
        [self.detailRequestSuccess sendNext:character];
    };
    MiewahRequestFailure failureHandler = ^(BaseResponseObject *payload){
        @strongify(self);
        [self.detailRequestFailure sendNext:[payload.comments componentsJoinedByString:@", "]];
    };
    MiewahRequestError errorHandler = ^(NSError *error){
        @strongify(self);
        [self.detailRequestError sendNext:error];
    };
    
    [self.requester getWordDetail:self.identifier
                          success:successHandler
                          failure:failureHandler
                            error:errorHandler];
}

- (NSArray <NSString *> *)makeContentToDisplay {
    return @[
             self.characterDetail.meaning ?: @"", // 意义
             @"", // 出处参考
             self.characterDetail.sentences ?: @"", // 例句
             self.characterDetail.prettifiedInputMethods ?: @"", //输入法
             @"", // 搜索关键字
             ];
}

- (RACSubject *)detailRequestSuccess {
    if (_detailRequestSuccess == nil) {
        _detailRequestSuccess = [[RACSubject alloc] init];
    }
    return _detailRequestSuccess;
}

- (RACSubject *)detailRequestFailure {
    if (_detailRequestFailure == nil) {
        _detailRequestFailure = [[RACSubject alloc] init];
    }
    return _detailRequestFailure;
}

- (RACSubject *)detailRequestError {
    if (_detailRequestError == nil) {
        _detailRequestError = [[RACSubject alloc] init];
    }
    return _detailRequestError;
}

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WordDetailSections" ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

- (MiewahWordDetailRequestManager *)requester {
    if (_requester == nil) {
        _requester = [[MiewahWordDetailRequestManager alloc] init];
    }
    return _requester;
}

@end
