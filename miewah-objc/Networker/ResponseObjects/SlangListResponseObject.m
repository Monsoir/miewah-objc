//
//  SlangListResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangListResponseObject.h"

@implementation SlangListResponseObject

+ (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseListReponseObject extractKeys];
    [keys addObjectsFromArray:@[NSStringFromSelector(@selector(slangs))]];
    return keys;
}

@end
