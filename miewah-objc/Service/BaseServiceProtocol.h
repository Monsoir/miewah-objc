//
//  BaseServiceProtocol.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahAsset.h"

typedef void(^ServiceGetListCompletion)(NSArray<MiewahAsset *> *list, NSError *error);
typedef void(^ServiceGetDetailCompletion)(MiewahAsset *asset, NSError *error);

@protocol BaseServiceProtocol <NSObject>

- (void)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion;
- (void)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion;

@end
