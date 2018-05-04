//
//  WordListResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordListResponseObject.h"

@implementation WordListResponseObject

+ (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseListReponseObject extractKeys];
    [keys addObjectsFromArray:@[NSStringFromSelector(@selector(words))]];
    return keys;
}

@end
