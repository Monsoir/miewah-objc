//
//  InputMethod.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/18.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const InputMethodCodeKey;
extern NSString * const InputMethodNameKey;
extern NSString * const InputMethodInputKey;

@interface InputMethod : NSObject

@property (nonatomic, copy) NSString *inputMethodCode;
@property (nonatomic, copy) NSString *inputMethodName;
@property (nonatomic, copy) NSString *input;

+ (instancetype)inputMethodWithCode:(NSString *)inputMethodCode name:(NSString *)inputMethodName input:(NSString *)input;

@end
