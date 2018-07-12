//
//  LocalAssetListViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/12.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "MiewahAsset.h"

@interface LocalAssetListViewModel : NSObject

@property (nonatomic, strong, readonly) RACSubject *readComplete;
@property (nonatomic, strong, readonly) NSMutableArray<MiewahAsset *> *items;

- (instancetype)initWithAssetType:(MiewahItemType)type;
- (void)fetchLocalAsset;
- (NSString *)sectionTitle;

@end
