//
//  BaseResponseObject.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponseObject : NSObject

@property (nonatomic, assign, readonly) NSNumber *success;
@property (nonatomic, strong, readonly) NSArray<NSString *> *comments;

/**
 从字典中生成对应的响应对象

 @param aDict 响应数据字典
 @return 响应对象
 */
- (instancetype)initWithDictionary:(NSDictionary *)aDict;

/**
 获取需要得到的响应字段
 
 子类需要重写此方法来返回响应字段，并且需要先调用父类的实现

 @return 一个包含所有需要的响应字段字符串的数组
 */
- (NSMutableArray<NSString *> *)extractKeys;

@end
