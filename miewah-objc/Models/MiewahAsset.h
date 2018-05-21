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

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;

+ (MiewahAsset *)assetOfType:(MiewahItemType)type;

@end
