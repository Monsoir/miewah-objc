//
//  MiewahFileMangerHelper.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahFileMangerHelper.h"
#import "FoundationConstants.h"

@implementation MiewahFileMangerHelper

+ (BOOL)deleteFileAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    return [DefaultFileManager removeItemAtPath:path error:error];
}

+ (BOOL)deleteFileInTmp:(NSString *)fileName error:(NSError *__autoreleasing *)error {
    return [DefaultFileManager removeItemAtPath:[TmpDirectory stringByAppendingPathComponent:fileName] error:error];
}

+ (BOOL)fileExistAtPath:(NSString *)path {
    return [DefaultFileManager fileExistsAtPath:path];
}

@end
