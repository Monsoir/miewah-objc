//
//  DatetimeHelper.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/5.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SharedDateFormatter [DatetimeHelper sharedDateFormatter]

@interface DatetimeHelper : NSObject

+ (NSDateFormatter *)sharedDateFormatter;

/**
 将 ISO 格式的日期转换为正常的日期显示，这里指 yyyy-MM-dd HH:mm
 
 @return 正常日期显示的字符串
 */
+ (NSString *)convertISODate2NormalFormatDate:(NSString *)anISODateString;

@end
