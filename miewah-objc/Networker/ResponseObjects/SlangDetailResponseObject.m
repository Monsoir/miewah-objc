//
//  SlangDetailResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangDetailResponseObject.h"

@implementation SlangDetailResponseObject

+ (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseResponseObject extractKeys];
    [keys addObjectsFromArray:@[
                                NSStringFromSelector(@selector(slang))
                                ]];
    return keys;
}

@end
