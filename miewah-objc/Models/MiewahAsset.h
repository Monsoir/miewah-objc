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

#warning 重构使用 LeanCloud 后，删除 identifier
@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sentences;

@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *updatedAt;

+ (MiewahAsset *)assetOfType:(MiewahItemType)type;

@end

@interface MiewahAsset(Datetime)

- (NSString *)normalFormatCreatedAt;
- (NSString *)normalFormatUpdatedAt;

@end
