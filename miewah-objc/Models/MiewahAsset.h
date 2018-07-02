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

@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sentences;

+ (MiewahAsset *)assetOfType:(MiewahItemType)type;

@end
