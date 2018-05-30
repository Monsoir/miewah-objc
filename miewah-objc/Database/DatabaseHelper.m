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

+ (void)cacheCharacterList:(NSArray<MiewahCharacter *> *)characters completion:(CacheCompletion)completion {
    [self cacheListOfType:MiewahItemTypeCharacter assets:characters completion:completion];
}

+ (void)cacheWordList:(NSArray<MiewahWord *> *)words completion:(CacheCompletion)completion {
    [self cacheListOfType:MiewahItemTypeWord assets:words completion:completion];
}

+ (void)cacheSlangList:(NSArray<MiewahSlang *> *)slangs completion:(CacheCompletion)completion {
    [self cacheListOfType:MiewahItemTypeSlang assets:slangs completion:completion];
}

+ (void)readCharacterListCacheCompletion:(ReadCacheCompletion)completion {
    [self readListCacheOfType:MiewahItemTypeCharacter completion:completion];
}

+ (void)readWordListCacheCompletion:(ReadCacheCompletion)completion {
    [self readListCacheOfType:MiewahItemTypeWord completion:completion];
}

+ (void)readSlangListCacheCompletion:(ReadCacheCompletion)completion {
    [self readListCacheOfType:MiewahItemTypeSlang completion:completion];
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
            asset.identifier = @([result intForColumnIndex:0]);
            asset.item = [result stringForColumnIndex:1];
            asset.pronunciation = [result stringForColumnIndex:2];
            asset.meaning = [result stringForColumnIndex:3];
            
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
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ VALUES ('%@', '%@', '%@', '%@')", tableName, asset.identifier, asset.item, asset.pronunciation, asset.meaning];
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
    NSString *createCharacterTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer, item text, pronunciation text, meaning text)", CharacterListCacheTableName];
    NSString *createWordTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer, item text, pronunciation text, meaning text)", WordListCacheTableName];
    NSString *createSlangTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer, item text, pronunciation text, meaning text)", SlangListCacheTableName];
    
    return [@[createCharacterTable, createWordTable, createSlangTable] componentsJoinedByString:@";"];
}

+ (NSString *)createFavorTablesSQLs {
    NSString *createCharacterTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer, item text, pronunciation text, meaning text, inputMethods text, sentences text, pronunciationVoice text, source text)", CharacterFavorTableName];
    NSString *createWordTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer, item text, pronunciation text, meaning text, sentences text, pronunciationVoice text)", WordFavorTableName];
    NSString *createSlangTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer, item text, pronunciation text, meaning text, pronunciationVoice text, source text)", SlangFavorTableName];
    
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
