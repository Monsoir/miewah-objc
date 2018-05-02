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

@property (nonatomic, copy) NSString *inputMethods;
@property (nonatomic, copy) NSString *sentences;
@property (nonatomic, copy) NSString *pronunciationVoice;

- (instancetype)initWithDictionary:(NSDictionary *)aDict;
- (NSDictionary *)deSerializeInputMethods;
- (NSString *)prettifiedInputMethods;

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

/**
 展示给用户的属性名

 @return 包含需要展示给用户的数据的属性名
 */
//+ (NSArray<NSString *> *)keysToDisplay;

@end
