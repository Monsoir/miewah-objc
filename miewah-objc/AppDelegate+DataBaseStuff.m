//
//  AppDelegate+DataBaseStuff.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AppDelegate+DataBaseStuff.h"
#import "DatabaseHelper.h"

@implementation AppDelegate (DataBaseStuff)

- (void)initializeDatabase {
    [DatabaseHelper createDatabasesCompletion:^(BOOL success, NSString *errorMsg) {
#warning 错误处理
        NSLog(@"complete");
        NSLog(@"%@", @(success));
        NSLog(@"%@", errorMsg);
    }];
}

@end
