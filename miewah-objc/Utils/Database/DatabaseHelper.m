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
    NSString *tableName = [self cacheTableNameOfType:type];
    if (tableName == nil) {
        completion(NO, nil, @"未找到表名");
        return;
    }
    
    [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
        static NSString *template = @"SELECT * FROM %@;";
        NSString *sql = [NSString stringWithFormat:template, tableName];
        NSMutableArray *assets = [NSMutableArray array];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            MiewahAsset *asset = [MiewahAsset assetOfType:type];
            asset.objectId = [result stringForColumnIndex:0];
            asset.item = [result stringForColumnIndex:1];
            asset.pronunciation = [result stringForColumnIndex:2];
            asset.meaning = [result stringForColumnIndex:3];
            asset.createdAt = [result stringForColumnIndex:5];
            asset.updatedAt = [result stringForColumnIndex:4];
            
            [assets addObject:asset];
        }
        [result close];
        completion(YES, assets, @"");
    }];
}

+ (void)cacheListOfType:(MiewahItemType)type assets:(NSArray<MiewahAsset *> *)assets completion:(CacheCompletion)completion {
    [self clearCacheOfType:type];
    
    NSString *tableName = [self cacheTableNameOfType:type];
    if (tableName == nil) {
        completion(false, @"未找到表名");
        return;
    }
    
    NSMutableArray *sqls = [NSMutableArray array];
    for (MiewahAsset *asset in assets) {
        static NSString *template = @"INSERT INTO %@ VALUES ('%@', '%@', '%@', '%@', '%@', '%@');";
        NSString *sql = [NSString stringWithFormat:template, tableName, asset.objectId, asset.item, asset.pronunciation, asset.meaning, asset.createdAt, asset.updatedAt];
        [sqls addObject:sql];
    }
    
    [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeStatements: [sqls componentsJoinedByString:@";"]];
        NSString *errorMsg = result ? @"" : [NSString stringWithFormat:@"%@ 缓存失败", tableName];
        completion(result, errorMsg);
    }];
}

+ (void)clearCacheOfType:(MiewahItemType)type {
    NSString *tableName = [self cacheTableNameOfType:type];
    
    if (tableName == nil) return;
    static NSString *template = @"DELETE FROM %@";
    NSString *deleteSQL = [NSString stringWithFormat:template, tableName];
    [CacheQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:deleteSQL];
    }];
}

+ (void)favorAnItemoOfType:(MiewahItemType)type detail:(MiewahAsset *)asset completion:(CacheCompletion)completion {
    NSArray *pair = [self insertOrUpdateSQLOfType:type asset:asset];
    NSString *tableName = pair.firstObject;
    if (!pair.firstObject) {
        completion(NO, @"未找到表名");
        return;
    }
    
    NSString *sql = pair[1];
    [FavorQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:sql];
        NSString *errorMsg = result ? @"" : [NSString stringWithFormat:@"%@ 收藏失败", tableName];
        if (result == NO) {
#if DEBUG
            NSLog(@"%@: %@", NSStringFromSelector(_cmd), [db lastError]);
#endif
        }
        completion(result, errorMsg);
    }];
}

+ (void)removeAnFavoriteItemOfType:(MiewahItemType)type identifier:(NSString *)identifier completion:(CacheCompletion)completion {
    NSString *tableName = [self favorTableNameOfType:type];
    if (tableName == nil) {
        completion(NO, @"未找到表名");
        return;
    }
    
    static NSString *template = @"DELETE FROM %@ WHERE objectId='%@';";
    NSString *sql = [NSString stringWithFormat:template, tableName, identifier];
    [FavorQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:sql];
        NSString *errorMsg = result ? @"" : [NSString stringWithFormat:@"%@ 取消收藏失败", tableName];
        if (result == NO) {
#if DEBUG
            NSLog(@"%@: %@", NSStringFromSelector(_cmd), [db lastError]);
#endif
        }
        completion(result, errorMsg);
    }];
}

+ (void)isFavoredItemofType:(MiewahItemType)type identifier:(NSString *)identifier completion:(void (^)(BOOL, NSString *))completion {
    NSString *tableName = [self favorTableNameOfType:type];
    if (tableName == nil) {
        completion(NO, @"未找到表名");
        return;
    }
    
    static NSString *template = @"SELECT COUNT(*) FROM %@ WHERE objectId='%@';";
    NSString *sql = [NSString stringWithFormat:template, tableName, identifier];
    [FavorQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:sql];
        if ([result next]) {
            int count = [result intForColumnIndex:0];
            [result close];
            completion(count > 0, nil);
            return;
        }
        
#if DEBUG
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), [db lastError]);
#endif
        [result close];
        completion(NO, @"查找失败");
    }];
}

+ (void)readItemFromFavorOfType:(MiewahItemType)type identifier:(NSString *)identifier completion:(void (^)(MiewahAsset *, NSString *))completion {
    NSString *tableName = [self favorTableNameOfType:type];
    if (tableName == nil) {
        completion(nil, @"未找到表名");
        return;
    }
    
    static NSString *readSQLTemplate = @"SELECT * FROM %@ WHERE objectId='%@'";
    NSString *sql = [NSString stringWithFormat:readSQLTemplate, tableName, identifier];
    [FavorQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:sql];
        if ([result next]) {
            MiewahAsset *asset = [self assetOfType:type fromFavorResult:result fetchingKeys:nil];
            [result close];
            completion(asset, nil);
        } else {
            [result close];
            completion(nil, @"");
        }
    }];
}

+ (void)readFavoredItemsOfType:(MiewahItemType)type skip:(NSInteger)skip size:(NSInteger)size completion:(void (^)(NSArray<MiewahAsset *> *, NSString *))completion {
    NSString *tableName = [self favorTableNameOfType:type];
    if (tableName == nil) {
        completion(nil, @"未找到表名");
        return;
    }
    
    NSArray<NSString *> *keys = @[@"objectId", @"item", @"pronunciation", @"updatedAt", @"meaning"];
    static NSString *readSQLTemplate = @"SELECT %@ FROM %@ ORDER BY updatedAt LIMIT %ld OFFSET %ld;";
    NSString *sql = [NSString stringWithFormat:readSQLTemplate, [keys componentsJoinedByString:@", "], tableName, size, skip];
    [FavorQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:sql];
        NSMutableArray *assets = [NSMutableArray array];
        while ([result next]) {
            MiewahAsset *asset = [self assetOfType:type fromFavorResult:result fetchingKeys:[NSSet setWithArray:keys]];
            [assets addObject:asset];
        }
        [result close];
        completion(assets, nil);
    }];
}

/*** Private ***/

+ (NSString *)createCacheTablesSQLs {
    static NSString *createCharacterTableSQLTemplate = @"CREATE TABLE IF NOT EXISTS %@ (objectId TEXT PRIMARY KEY, item TEXT, pronunciation TEXT, meaning TEXT, createdAt TEXT, updatedAt TEXT)";
    static NSString *createWordTableSQLTemplate = @"CREATE TABLE IF NOT EXISTS %@ (objectId TEXT PRIMARY KEY, item TEXT, pronunciation TEXT, meaning TEXT, createdAt TEXT, updatedAt TEXT)";
    static NSString *createSlangTableSQLTemplate = @"CREATE TABLE IF NOT EXISTS %@ (objectId TEXT PRIMARY KEY, item TEXT, pronunciation TEXT, meaning TEXT, createdAt TEXT, updatedAt TEXT)";
    
    NSString *createCharacterTableSQL = [NSString stringWithFormat:createCharacterTableSQLTemplate, CharacterListCacheTableName];
    NSString *createWordTableSQL = [NSString stringWithFormat:createWordTableSQLTemplate, WordListCacheTableName];
    NSString *createSlangTableSQL = [NSString stringWithFormat:createSlangTableSQLTemplate, SlangListCacheTableName];
    
    return [@[createCharacterTableSQL, createWordTableSQL, createSlangTableSQL] componentsJoinedByString:@";"];
}

+ (NSString *)createFavorTablesSQLs {
    // 创建表
    static NSString *createCharacterTableSQLTemplate = @"CREATE TABLE IF NOT EXISTS %@ (objectId text PRIMARY KEY, item text NOT NULL UNIQUE, pronunciation text, meaning text, inputMethods text, sentences text, pronunciationVoice text, source text, createdAt text, updatedAt text)";
    static NSString *createWordTableSQLTemplate = @"CREATE TABLE IF NOT EXISTS %@ (objectId text PRIMARY KEY, item text NOT NULL UNIQUE, pronunciation text, meaning text, sentences text, pronunciationVoice text, createdAt text, updatedAt text)";
    static NSString *createSlangTableSQLTemplate = @"CREATE TABLE IF NOT EXISTS %@ (objectId text PRIMARY KEY, item text NOT NULL UNIQUE, pronunciation text, meaning text, pronunciationVoice text, source text, sentences text, createdAt text, updatedAt text)";
    
    NSString *createCharacterTableSQL = [NSString stringWithFormat:createCharacterTableSQLTemplate, CharacterFavorTableName];
    NSString *createWordTableSQL = [NSString stringWithFormat:createWordTableSQLTemplate, WordFavorTableName];
    NSString *createSlangTableSQL = [NSString stringWithFormat:createSlangTableSQLTemplate, SlangFavorTableName];
    
    // 创建索引
    static NSString *createTableIndexSQLTemplate = @"CREATE INDEX IF NOT EXISTS %@_object_id_index ON %@ (objectId);CREATE INDEX IF NOT EXISTS %@_item_index ON %@ (item);";
    
    NSString *createCharacterTableIndexSQL = [NSString stringWithFormat:createTableIndexSQLTemplate, CharacterFavorTableName, CharacterFavorTableName, CharacterFavorTableName, CharacterFavorTableName];
    NSString *createWordTableIndexSQL = [NSString stringWithFormat:createTableIndexSQLTemplate, WordFavorTableName, WordFavorTableName, WordFavorTableName, WordFavorTableName];
    NSString *createSlangTableIndexSQL = [NSString stringWithFormat:createTableIndexSQLTemplate, SlangFavorTableName, SlangFavorTableName, SlangFavorTableName, SlangFavorTableName];
    
    return [@[createCharacterTableSQL, createWordTableSQL, createSlangTableSQL, createCharacterTableIndexSQL, createWordTableIndexSQL, createSlangTableIndexSQL] componentsJoinedByString:@";"];
}

+ (NSString *)cacheTableNameOfType:(MiewahItemType)type {
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

+ (NSString *)favorTableNameOfType:(MiewahItemType)type {
    NSString *tableName = nil;
    switch (type) {
        case MiewahItemTypeCharacter:
            tableName = CharacterFavorTableName;
            break;
        case MiewahItemTypeWord:
            tableName = WordFavorTableName;
            break;
        case MiewahItemTypeSlang:
            tableName = SlangFavorTableName;
            break;
            
        default:
            break;
    }
    return tableName;
}

+ (NSArray<NSString *> *)insertOrUpdateSQLOfType:(MiewahItemType)type asset:(MiewahAsset *)asset {
    NSString *tableName = [self favorTableNameOfType:type];
    if (tableName == nil) return @[@"", @""];
    
    NSString *sql = @"";
    switch (type) {
        case MiewahItemTypeCharacter:
        {
            MiewahCharacter *a = (MiewahCharacter *)asset;
            static NSString *template = @"INSERT OR REPLACE INTO %@ VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');";
            sql = [NSString stringWithFormat:template, tableName, a.objectId, a.item, a.pronunciation, a.meaning, a.inputMethods, a.sentences, a.pronunciationVoice, a.source, a.createdAt, a.updatedAt];
            break;
        }
        case MiewahItemTypeWord:
        {
            MiewahWord *a = (MiewahWord *)asset;
            static NSString *template = @"INSERT OR REPLACE INTO %@ VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');";
            sql = [NSString stringWithFormat:template, tableName, a.objectId, a.item, a.pronunciation, a.meaning, a.sentences, a.pronunciationVoice, a.createdAt, a.updatedAt];
            break;
        }
        case MiewahItemTypeSlang:
        {
            MiewahSlang *a = (MiewahSlang *)asset;
            static NSString *template = @"INSERT OR REPLACE INTO %@ VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');";
            sql = [NSString stringWithFormat:template, tableName, a.objectId, a.item, a.pronunciation, a.meaning, a.pronunciationVoice, a.source, a.sentences, a.createdAt, a.updatedAt];
            break;
        }
            
        default:
            sql = @"";
    }
    return @[alwaysString(tableName), alwaysString(sql)];
}


/**
 判断不同的 asset 类型，生成不同的 asset
 
 keys 用于与 MiewahAsset 中所有的属性进行交集操作，确定需要转换哪些类型

 @param type asset 类型
 @param result 数据库返回对象
 @param keys 需要进行转换的属性名，避免 FMDB 警告找不到列名，传 nil 表示检索 MiewahAsset 的所有属性
 @return 转换后的 MiewahAsset 对象
 */
+ (MiewahAsset *)assetOfType:(MiewahItemType)type fromFavorResult:(FMResultSet *)result fetchingKeys:(NSSet<NSString *> *)keys {
    switch (type) {
        case MiewahItemTypeCharacter:
            return [self characterAssetFromFavorResult:result fetchingKeys:keys];
        case MiewahItemTypeWord:
            return [self wordAssetFromFavorResult:result fetchingKeys:keys];
        case MiewahItemTypeSlang:
            return [self slangAssetFromFavorResult:result fetchingKeys:keys];
        default:
            return nil;
    }
}

+ (MiewahCharacter *)characterAssetFromFavorResult:(FMResultSet *)result fetchingKeys:(NSSet<NSString *> *)keys {
    NSSet *propertyNames = [MiewahCharacter propertiesListInheritedFromClass:[MiewahAsset class]];
    if (keys) {
        NSMutableSet *interactionSet = [[NSMutableSet alloc] initWithSet:propertyNames];
        [interactionSet intersectSet:keys];
        propertyNames = [interactionSet copy];
    }
    NSMutableDictionary *objectInfo = [NSMutableDictionary dictionary];
    for (NSString *propertyName in propertyNames) {
        objectInfo[propertyName] = [result stringForColumn:propertyName];
    }
    MiewahCharacter *asset = [[MiewahCharacter alloc] initWithDictionary:objectInfo];
    return asset;
}

+ (MiewahWord *)wordAssetFromFavorResult:(FMResultSet *)result fetchingKeys:(NSSet<NSString *> *)keys {
    NSSet *propertyNames = [MiewahWord propertiesListInheritedFromClass:[MiewahAsset class]];
    if (keys) {
        NSMutableSet *interactionSet = [[NSMutableSet alloc] initWithSet:propertyNames];
        [interactionSet intersectSet:keys];
        propertyNames = [interactionSet copy];
    }
    NSMutableDictionary *objectInfo = [NSMutableDictionary dictionary];
    for (NSString *propertyName in propertyNames) {
        objectInfo[propertyName] = [result stringForColumn:propertyName];
    }
    MiewahWord *asset = [[MiewahWord alloc] initWithDictionary:objectInfo];
    return asset;
}

+ (MiewahSlang *)slangAssetFromFavorResult:(FMResultSet *)result fetchingKeys:(NSSet<NSString *> *)keys {
    NSSet *propertyNames = [MiewahSlang propertiesListInheritedFromClass:[MiewahAsset class]];
    if (keys) {
        NSMutableSet *interactionSet = [[NSMutableSet alloc] initWithSet:propertyNames];
        [interactionSet intersectSet:keys];
        propertyNames = [interactionSet copy];
    }
    NSMutableDictionary *objectInfo = [NSMutableDictionary dictionary];
    for (NSString *propertyName in propertyNames) {
        objectInfo[propertyName] = [result stringForColumn:propertyName];
    }
    MiewahSlang *asset = [[MiewahSlang alloc] initWithDictionary:objectInfo];
    return asset;
}

+ (NSString *)cacheDatabasePath {
    return [CachesDirectory stringByAppendingPathComponent:CacheDatabaseFileName];
}

+ (NSString *)favorDatabasePath {
    return [DocumentDirectory stringByAppendingPathComponent:FavorDatabaseFileName];
}

@end
