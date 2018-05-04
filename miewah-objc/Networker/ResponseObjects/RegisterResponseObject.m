//
//  RegisterResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "RegisterResponseObject.h"

@implementation RegisterResponseObject

- (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseResponseObject extractKeys];
    [keys addObject:NSStringFromSelector(@selector(validateErrorMsg))];
    return keys;
}

@end
