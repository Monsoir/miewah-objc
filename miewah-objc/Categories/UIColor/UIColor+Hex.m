//
//  UIColor+Hex.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

- (instancetype)initWithHexString:(NSString *)hexStringToConvert{
    
    //将字符串中的空格去掉，并转换成大写
    NSString *cString = [[hexStringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] uppercaseString];
    
    //从非 # 开始扫描
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)(r / 255.0f)
                           green:(float)(g / 255.0f)
                            blue:(float)(b / 255.0f)
                           alpha:1.0];
}

+ (instancetype)colorWithHexString:(NSString *)hexStringToConvert{
    return [[UIColor alloc] initWithHexString:hexStringToConvert];
}

@end
