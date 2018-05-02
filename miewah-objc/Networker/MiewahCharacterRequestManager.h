//
//  MiewahCharacterRequestManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"
#import "MiewahRequestProtocol.h"

@interface MiewahCharacterRequestManager : NSObject<MiewahListRequestProtocol, MiewahDetailRequestProtocol>

@end
