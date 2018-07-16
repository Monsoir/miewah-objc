//
//  NSDictionary+JoinString.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JoinString)

/**
 将字典中的条目转换为 [key1]=[value1][separator][key2]=[value2]
 
 字典中的 key value 格式需为 <NSString *, NSString *>

 @param separator 每一对 key value 的分隔符
 @return 字典中每对 key value 的合成字符串
 */
- (NSString *)joinBySeparator:(NSString *)separator;

/**
 将字典中的条目转换为 query 参数，同时会对中文进行转义
 
 即 [key1]=[value1]&[key2]=[value2]

 @return 字典中每对 key value 转换为 query 参数的合成字符串
 */
- (NSString *)queryParams;

@end
