//
//  Validator.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

/**
 邮箱格式验证

 @param email 待验证的邮箱地址
 @return YES 若邮箱地址合法，否则，NO
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 验证字符串长度

 @param aString 待验证的字符串
 @param length 字符串最小长度
 @return YES 若字符串符合最小长度，否则，NO
 */
+ (BOOL)validateString:(NSString *)aString length:(NSInteger)length;

@end
