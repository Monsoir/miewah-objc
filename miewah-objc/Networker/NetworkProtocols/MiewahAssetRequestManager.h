//
//  MiewahAssetRequestManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahRequestProtocol.h"
#import "MiewahNetworker.h"
#import "FoundationConstants.h"
#import "MiewahPostNetworker.h"

@interface MiewahAssetRequestManager : NSObject<MiewahListRequestProtocol, MiewahDetailRequestProtocol, MiewahAssetSubmitProtocol>

@property (nonatomic, strong, readonly) MiewahPostNetworker *requester;

+ (instancetype)requestManagerOfType:(MiewahItemType)type;

@end
