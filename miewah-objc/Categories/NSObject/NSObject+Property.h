//
//  NSObject+Property.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/10.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)


/**
 获取当前类中的所有属性，属性包括从 aClass 这个父类中继承的
 
 若 aClass 为 nil, 则只返回当前类的属性名称集合，不包括父类

 @return 类的属性集合
 */
+ (NSSet<NSString *> *)propertiesListInheritedFromClass:(Class)aClass;

@end
