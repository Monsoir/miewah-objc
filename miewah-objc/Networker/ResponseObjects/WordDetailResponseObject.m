//
//  WordDetailResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordDetailResponseObject.h"

@implementation WordDetailResponseObject

+ (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseResponseObject extractKeys];
    [keys addObjectsFromArray:@[
                                NSStringFromSelector(@selector(word))
                                ]];
    return keys;
}

@end
