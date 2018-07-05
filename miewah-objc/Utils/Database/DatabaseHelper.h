//
//  DatabaseHelper.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahCharacter.h"
#import "MiewahWord.h"
#import "MiewahSlang.h"

typedef void(^CreateDatabasesCompletion)(BOOL success, NSString *errorMsg);
typedef void(^CacheCompletion)(BOOL success, NSString *errorMsg);
typedef void(^ReadCacheCompletion)(BOOL success, NSArray<MiewahAsset *> *assets, NSString *errorMsg);

@interface DatabaseHelper : NSObject

+ (void)createDatabasesCompletion:(CreateDatabasesCompletion)completion;

+ (void)cacheListOfType:(MiewahItemType)type assets:(NSArray<MiewahAsset *> *)assets completion:(CacheCompletion)completion;

+ (void)readListCacheOfType:(MiewahItemType)type completion:(ReadCacheCompletion)completion;

@end
