//
//  DatabaseHelper.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <FMDB/FMDB.h>

#import "DatabaseHelper.h"
#import "FoundationConstants.h"

// 数据库文件名
static NSString * CacheDatabaseFileName = @"cache.sqlite";
static NSString * FavorDatabaseFileName = @"favor.sqlite";

// 数据库名
static NSString * CharacterListCacheTableName = @"character_cache";
static NSString * WordListCacheTableName = @"word_cache";
static NSString * SlangListCacheTableName = @"slang_cache";

static NSString * CharacterFavorTableName = @"character_favor";
static NSString * WordFavorTableName = @"word_favor";
static NSString * SlangFavorTableName = @"slang_favor";

#define CacheQueue [FMDatabaseQueue databaseQueueWithPath:[self cacheDatabasePath]]
#define FavorQueue [FMDatabaseQueue databaseQueueWithPath:[self favorDatabasePath]]

@implementation DatabaseHelper

+ (void)createDatabasesCompletion:(CreateDatabasesCompletion)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
        
        __block BOOL cacheTablesCreateResult = NO;
        [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
            cacheTablesCreateResult = [db executeStatements:[self createCacheTablesSQLs]];
            dispatch_semaphore_signal(semaphore);
        }];
        
        __block BOOL favorTablesCreateResult = NO;
        [FavorQueue inDatabase:^(FMDatabase * _Nonnull db) {
            favorTablesCreateResult = [db executeStatements:[self createFavorTablesSQLs]];
            dispatch_semaphore_signal(semaphore);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        BOOL success = cacheTablesCreateResult || favorTablesCreateResult;
        NSString *errorMsg = success ? @"" : @"缓存数据库或收藏数据库创建失败";
        completion(YES, errorMsg);
    });
}

+ (void)readListCacheOfType:(MiewahItemType)type completion:(ReadCacheCompletion)completion {
    NSString *tableName = [self tableNameOfType:type];
    if (tableName == nil) {
        completion(NO, nil, @"未找到表名");
        return;
    }
    
    [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
        NSMutableArray *assets = [NSMutableArray array];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            MiewahAsset *asset = [MiewahAsset assetOfType:type];
            asset.identifier = [result stringForColumnIndex:0];
            asset.item = [result stringForColumnIndex:1];
            asset.pronunciation = [result stringForColumnIndex:2];
            asset.meaning = [result stringForColumnIndex:3];
            asset.createdAt = [result stringForColumnIndex:5];
            asset.updatedAt = [result stringForColumnIndex:4];
            
            [assets addObject:asset];
        }
        completion(YES, assets, @"");
    }];
}

+ (void)cacheListOfType:(MiewahItemType)type assets:(NSArray<MiewahAsset *> *)assets completion:(CacheCompletion)completion {
    [self clearCacheOfType:type];
    
    NSString *tableName = [self tableNameOfType:type];
    if (tableName == nil) {
        completion(false, @"未找到表名");
        return;
    }
    
    NSMutableArray *sqls = [NSMutableArray array];
    for (MiewahAsset *asset in assets) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", tableName, asset.objectId, asset.item, asset.pronunciation, asset.meaning, asset.createdAt, asset.updatedAt];
        [sqls addObject:sql];
    }
    
    [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeStatements: [sqls componentsJoinedByString:@";"]];
        NSString *errorMsg = result ? @"" : [NSString stringWithFormat:@"%@ 缓存失败", tableName];
        completion(result, errorMsg);
    }];
}

+ (void)clearCacheOfType:(MiewahItemType)type {
    NSString *tableName = [self tableNameOfType:type];
    
    if (tableName == nil) return;
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:deleteSQL];
    }];
}

+ (NSString *)createCacheTablesSQLs {
    NSString *createCharacterTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (objectId text, item text, pronunciation text, meaning text, createdAt text, updatedAt text)", CharacterListCacheTableName];
    NSString *createWordTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (objectId text, item text, pronunciation text, meaning text, createdAt text, updatedAt text)", WordListCacheTableName];
    NSString *createSlangTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (objectId text, item text, pronunciation text, meaning text, createdAt text, updatedAt text)", SlangListCacheTableName];
    
    return [@[createCharacterTable, createWordTable, createSlangTable] componentsJoinedByString:@";"];
}

+ (NSString *)createFavorTablesSQLs {
    NSString *createCharacterTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (objectId text, item text, pronunciation text, meaning text, inputMethods text, sentences text, pronunciationVoice text, source text, createdAt text, updatedAt text)", CharacterFavorTableName];
    NSString *createWordTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (objectId text, item text, pronunciation text, meaning text, sentences text, pronunciationVoice text, createdAt text, updatedAt text)", WordFavorTableName];
    NSString *createSlangTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (objectId text, item text, pronunciation text, meaning text, pronunciationVoice text, source text, createdAt text, updatedAt text)", SlangFavorTableName];
    
    return [@[createCharacterTable, createWordTable, createSlangTable] componentsJoinedByString:@";"];
}

+ (NSString *)tableNameOfType:(MiewahItemType)type {
    NSString *tableName = nil;
    switch (type) {
        case MiewahItemTypeCharacter:
            tableName = CharacterListCacheTableName;
            break;
        case MiewahItemTypeWord:
            tableName = WordListCacheTableName;
            break;
        case MiewahItemTypeSlang:
            tableName = SlangListCacheTableName;
            break;
            
        default:
            break;
    }
    return tableName;
}

+ (NSString *)cacheDatabasePath {
    return [CachesDirectory stringByAppendingPathComponent:CacheDatabaseFileName];
}

+ (NSString *)favorDatabasePath {
    return [DocumentDirectory stringByAppendingPathComponent:FavorDatabaseFileName];
}

@end
