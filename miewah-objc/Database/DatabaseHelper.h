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

+ (void)cacheCharacterList:(NSArray<MiewahCharacter *> *)characters completion:(CacheCompletion)completion;
+ (void)cacheWordList:(NSArray<MiewahWord *> *)words completion:(CacheCompletion)completion;
+ (void)cacheSlangList:(NSArray<MiewahSlang *> *)slangs completion:(CacheCompletion)completion;

+ (void)readCharacterListCacheCompletion:(ReadCacheCompletion)completion;
+ (void)readWordListCacheCompletion:(ReadCacheCompletion)completion;
+ (void)readSlangListCacheCompletion:(ReadCacheCompletion)completion;

@end
