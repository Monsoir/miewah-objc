//
//  AppDelegate+TestForDevelopment.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AppDelegate+TestForDevelopment.h"
#import "MiewahUser.h"
#import "FoundationConstants.h"

@implementation AppDelegate (TestForDevelopment)

- (void)clearLoginInfo {
    [[MiewahUser thisUser] clearUserInfo];
}

- (void)logSandBoxPaths {
    NSLog(@"home: %@", HomeDirectory);
    NSLog(@"Document: %@", DocumentDirectory);
    NSLog(@"Cache: %@", CachesDirectory);
    NSLog(@"tmp: %@", TmpDirectory);
}

@end
