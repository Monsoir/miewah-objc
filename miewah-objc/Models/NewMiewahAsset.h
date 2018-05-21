//
//  NewMiewahInstance.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoundationConstants.h"
#import "MiewahAsset.h"

@interface NewMiewahAsset : NSObject

@property (nonatomic, assign) MiewahItemType type;
@property (nonatomic, strong, readonly) MiewahAsset *currentAsset;

+ (NewMiewahAsset *)sharedAsset;

@end
