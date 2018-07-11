//
//  MiewahDetailViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "BaseServiceProtocol.h"
#import "MiewahAsset.h"

@interface MiewahDetailViewModel : MiewahViewModel

@property (nonatomic, strong, readonly) MiewahAsset *asset;
@property (nonatomic, assign, readonly) BOOL favored;
@property (nonatomic, strong, readonly) id<BaseServiceProtocol> service;
@property (nonatomic, weak, readonly) RACSubject *loadedSuccess;
@property (nonatomic, weak, readonly) RACSubject *loadedFailure;
@property (nonatomic, strong, readonly) RACSubject *readFavorComplete;
@property (nonatomic, strong, readonly) RACSignal *loadingSignal;

/**
 指 favor 中有或者请求成功
 */
@property (nonatomic, strong, readonly) RACSignal *assetExistSignal;
@property (nonatomic, strong, readonly) RACSignal *favorSignal;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

- (instancetype)initWithInfo:(NSDictionary *)userInfo;
- (void)readFromFavor;
- (void)loadData;
- (NSArray <NSString *> *)makeContentToDisplay;
- (void)favorAsset;
- (void)unfavorAsset;

@end
