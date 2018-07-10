//
//  MiewahAsset.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahModel.h"
#import "FoundationConstants.h"

@interface MiewahAsset : MiewahModel

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sentences;

@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *updatedAt;

+ (MiewahAsset *)assetOfType:(MiewahItemType)type;
+ (NSSet<NSString *> *)propertyList;

@end

@interface MiewahAsset(Datetime)

- (NSString *)normalFormatCreatedAt;
- (NSString *)normalFormatUpdatedAt;

@end
