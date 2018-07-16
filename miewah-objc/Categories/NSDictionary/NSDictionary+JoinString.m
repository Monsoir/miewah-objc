//
//  NSDictionary+JoinString.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "NSDictionary+JoinString.h"

@implementation NSDictionary (JoinString)

- (NSString *)joinBySeparator:(NSString *)separator {
    NSMutableString *result = [NSMutableString string];
    NSString *_separator = separator ?: @"";
    for (NSString *key in [self allKeys]) {
        if (result.length > 0) {
            [result appendString:_separator];
        }
        [result appendString:[NSString stringWithFormat:@"%@=%@", key, [self objectForKey:key]]];
    }
    return [result copy];
}

- (NSString *)queryParams {
    // 对于 query params, 需要对中文进行转义
    return [[self joinBySeparator:@"&"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
