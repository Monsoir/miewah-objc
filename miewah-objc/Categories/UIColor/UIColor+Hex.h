//
//  UIColor+Hex.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  根据传入的十六进制字符串转换成相应的颜色
 *
 *  @param hexStringToConvert 代表颜色的十六进制字符串
 *
 *  @return 转换后的颜色
 */
+ (instancetype)colorWithHexString:(NSString *)hexStringToConvert;

@end
