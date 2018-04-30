//
//  LoginResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LoginResponseObject.h"

@implementation LoginResponseObject

- (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [super extractKeys];
    [keys addObject:NSStringFromSelector(@selector(token))];
    return keys;
}

@end
