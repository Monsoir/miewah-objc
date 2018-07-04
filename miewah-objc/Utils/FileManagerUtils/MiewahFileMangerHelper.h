//
//  MiewahFileMangerHelper.h
//  miewah-objc
//
//  Created by Christopher on 2018/6/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DefaultFileManager [NSFileManager defaultManager]

@interface MiewahFileMangerHelper : NSObject

+ (BOOL)deleteFileAtPath:(NSString *)path error:(NSError **)error;
+ (BOOL)deleteFileInTmp:(NSString *)fileName error:(NSError **)error;

+ (BOOL)fileExistAtPath:(NSString *)path;

@end
