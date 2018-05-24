//
//  EditPreviewViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditPreviewViewModel.h"
#import "NewMiewahAsset.h"

@interface EditPreviewViewModel()

@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) NSArray<NSString *> *displayContents;

@property (nonatomic, assign) MiewahItemType type;
@property (nonatomic, strong) MiewahAssetRequestManager *requester;

@property (nonatomic, strong) RACSubject *postSuccess;
@property (nonatomic, strong) RACSubject *postFailure;
@property (nonatomic, strong) RACSubject *postError;

@end

@implementation EditPreviewViewModel

- (BOOL)postData {
    @weakify(self);
    MiewahRequestSuccess successHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        [self.postSuccess sendNext:nil];
    };
    
    MiewahRequestFailure failureHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        NSDictionary *userInfo = @{
                                   MiewahRequestErrorCodeKey: @(MiewahRequestErrorCodeUnknown),
                                   MiewahRequestErrorMessageKey: [payload.comments componentsJoinedByString:@", "],
                                   };
        [self.postFailure sendNext:userInfo];
    };
    
    MiewahRequestError errorHandler = ^(NSError *error) {
        @strongify(self);
        NSDictionary *userInfo = error.userInfo;
        NSInteger statusCode = [[userInfo valueForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        if (statusCode == 401) {
            NSDictionary *userInfo = @{
                                       MiewahRequestErrorCodeKey: @(MiewahRequestErrorCodeUnauthorized),
                                       MiewahRequestErrorMessageKey: @"请先登录",
                                       };
            [self.postFailure sendNext:userInfo];
            return;
        }
        
        [self.postError sendNext:error];
    };
    
    NSDictionary *params = [self postParams];
    [self.requester postNewAsset:params
                         success:successHandler
                         failure:failureHandler
                           error:errorHandler];
    
    return YES;
}

- (NSDictionary *)postParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"item"] = alwaysString(CurrentEditingAsset.item);
    params[@"pronunciation"] = alwaysString(CurrentEditingAsset.pronunciation);
    params[@"meaning"] = alwaysString(CurrentEditingAsset.meaning);
    params[@"source"] = alwaysString(CurrentEditingAsset.source);
    params[@"sentences"] = alwaysString(CurrentEditingAsset.sentences);
//    params[@"pronunciationVoice"] = @"";
    
    if (self.type == MiewahItemTypeCharacter) {
        MiewahCharacter *temp = (MiewahCharacter *)CurrentEditingAsset;
        params[@"inputMethods"] = temp.inputMethods;
    }
    
    return [params copy];
}

- (NSArray<NSString *> *)displayContents {
    
    switch (self.type) {
        case MiewahItemTypeCharacter:
        {
            MiewahCharacter *temp = (MiewahCharacter *)[NewMiewahAsset sharedAsset].currentAsset;
            NSArray *result = @[
                                alwaysString(temp.meaning),
                                alwaysString(temp.source),
                                alwaysString(temp.sentences),
                                alwaysString(temp.inputMethods),
                                @"", // 查询关键字
                                ];
            return result;
        }
        case MiewahItemTypeWord:
        {
            MiewahWord *temp = (MiewahWord *)[NewMiewahAsset sharedAsset].currentAsset;
            NSArray *result = @[
                                alwaysString(temp.meaning),
                                alwaysString(temp.source),
                                alwaysString(temp.sentences),
                                @"",
                                @"",
                                ];
            return result;
        }
        case MiewahItemTypeSlang:
        {
            MiewahSlang *temp = (MiewahSlang *)[NewMiewahAsset sharedAsset].currentAsset;
            NSArray *result = @[
                                alwaysString(temp.meaning),
                                alwaysString(temp.source),
                                alwaysString(temp.sentences),
                                @"",
                                ];
            return result;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *fileName = nil;
        switch (self.type) {
            case MiewahItemTypeCharacter:
                fileName = @"WordDetailSections";
                break;
            case MiewahItemTypeWord:
                fileName = @"WordDetailSections";
                break;
            case MiewahItemTypeSlang:
                fileName = @"SlangDetailSections";
                break;
                
            default:
                break;
        }
        if (fileName == nil) return nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

- (MiewahItemType)type {
    return [NewMiewahAsset sharedAsset].type;
}

- (MiewahAssetRequestManager *)requester {
    if (_requester == nil) {
        _requester = [MiewahAssetRequestManager requestManagerOfType:[NewMiewahAsset sharedAsset].type];
    }
    return _requester;
}

- (RACSubject *)postSuccess {
    if (_postSuccess == nil) {
        _postSuccess = [[RACSubject alloc] init];
    }
    return _postSuccess;
}

- (RACSubject *)postFailure {
    if (_postFailure == nil) {
        _postFailure = [[RACSubject alloc] init];
    }
    return _postFailure;
}

- (RACSubject *)postError {
    if (_postError == nil) {
        _postError = [[RACSubject alloc] init];
    }
    return _postError;
}

@end
