//
//  DatetimeHelper.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/5.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "DatetimeHelper.h"

@implementation DatetimeHelper

+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NSDateFormatter alloc] init];
    });
    return instance;
}

+ (NSString *)convertISODate2NormalFormatDate:(NSString *)anISODateString {
    // 将 ISO 日期转换为 NSDate
    SharedDateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
    NSDate *date = [SharedDateFormatter dateFromString:anISODateString];
    
    // 将 NSDate 转换为 yyyy-MM-dd HH:mm
    SharedDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *result = [SharedDateFormatter stringFromDate:date];
    return result;
}

@end
