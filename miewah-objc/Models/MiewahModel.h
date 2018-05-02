//
//  MiewahModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiewahModel : NSObject

/**
 从字典中创建对象

 @param aDict 包含对象属性的字典
 @return 返回对应的对象
 */
- (instancetype)initWithDictionary:(NSDictionary *)aDict;

/**
 可以直接获取的属性名称
 
 @return 包含可以直接获取的属性名称的数组
 */
+ (NSArray<NSString *> *)extractKeys;

/**
 需要转义获取的属性名称
 
 原名称 : 对象属性名称
 
 @return 包含需要转义获取的属性名称
 */
+ (NSDictionary *)escapedKeys;

@end
