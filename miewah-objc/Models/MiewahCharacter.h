//
//  MiewahCharacter.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiewahCharacter : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *character;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;

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
