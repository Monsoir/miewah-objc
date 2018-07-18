//
//  InputMethod.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/18.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "InputMethod.h"

NSString * const InputMethodCodeKey = @"inputMethodCode";
NSString * const InputMethodNameKey = @"inputMethodName";
NSString * const InputMethodInputKey = @"input";

@implementation InputMethod

+ (instancetype)inputMethodWithCode:(NSString *)inputMethodCode name:(NSString *)inputMethodName input:(NSString *)input {
    InputMethod *method = [[InputMethod alloc] init];
    if (method) {
        method.inputMethodCode = inputMethodCode;
        method.inputMethodName = inputMethodName;
        method.input = input;
    }
    return method;
}

@end
