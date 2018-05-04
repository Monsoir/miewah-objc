//
//  MiewahSlangRequesterManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"
#import "MiewahRequestProtocol.h"

@interface MiewahSlangRequesterManager : NSObject<MiewahListRequestProtocol, MiewahDetailRequestProtocol>

@end
