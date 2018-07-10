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
typedef void(^ReadFavorItemCompletion)(BOOL success, MiewahAsset *asset, NSString *errorMsg);

@interface DatabaseHelper : NSObject

+ (void)createDatabasesCompletion:(CreateDatabasesCompletion)completion;

+ (void)cacheListOfType:(MiewahItemType)type assets:(NSArray<MiewahAsset *> *)assets completion:(CacheCompletion)completion;

+ (void)readListCacheOfType:(MiewahItemType)type completion:(ReadCacheCompletion)completion;


/**
 保存一个 asset 到本地
 
 重复保存同一个 asset 作更新操作

 @param type asset 类型
 @param asset asset 内容
 @param completion 保存完成回调
 */
+ (void)favorAnItemoOfType:(MiewahItemType)type detail:(MiewahAsset *)asset completion:(CacheCompletion)completion;

/**
 从本地移除一个 asset

 @param type asset 类型
 @param identifier 内容
 @param completion 移除完成后回调
 */
+ (void)removeAnFavoriteItemOfType:(MiewahItemType)type identifier:(NSString *)identifier completion:(CacheCompletion)completion;

/**
 判断 asset 是否被 favord

 @param type asset 类型
 @param identifier asset 标识符
 @param completion 判断完成回调
 */
+ (void)isFavoredItemofType:(MiewahItemType)type identifier:(NSString *)identifier completion:(void(^)(BOOL favored, NSString *errorMsg))completion;

/**
 从 favor 中读取 asset

 @param type asset 类型
 @param identifier asset 标识符
 @param completion 读取完成回调
 */
+ (void)readItemFromFavorOfType:(MiewahItemType)type identifier:(NSString *)identifier completion:(void(^)(MiewahAsset *asset, NSString *errorMsg))completion;

//+ (void)readFromFavorForAnItem:(NSString *)itemId ofType:(MiewahItemType)type completion:(ReadFavorItemCompletion)completion;
//+ (void)readFromFavorForItemListOfType:(MiewahItemType)type;

@end
