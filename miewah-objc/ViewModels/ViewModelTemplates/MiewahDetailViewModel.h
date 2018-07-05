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
@property (nonatomic, strong, readonly) id<BaseServiceProtocol> service;
@property (nonatomic, strong, readonly) RACSubject *loadedSuccess;
@property (nonatomic, strong, readonly) RACSubject *loadedFailure;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

- (instancetype)initWithInfo:(NSDictionary *)userInfo;
- (void)loadData;
- (NSArray <NSString *> *)makeContentToDisplay;

@end
