//
//  BaseResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "BaseResponseObject.h"
#import "RegisterResponseObject.h"
#import "LoginResponseObject.h"
#import "CharacterListResponseObject.h"
#import "CharacterDetailResponseObject.h"

@implementation BaseResponseObject

+ (instancetype)responseObjectOfType:(ResponseObjectType)type configuredWithDict:(NSDictionary *)aDict {
    switch (type) {
        case ResponseObjectTypeRegister:
            return [[RegisterResponseObject alloc] initWithDictionary:aDict];
        case ResponseObjectTypeLogin:
            return [[LoginResponseObject alloc] initWithDictionary:aDict];
        case ResponseObjectTypeCharacterList:
            return [[CharacterListResponseObject alloc] initWithDictionary:aDict];
        case ResponseObjectTypeCharacterDetail:
            return [[CharacterDetailResponseObject alloc] initWithDictionary:aDict];
        case ResponseObjectTypeWordList:
            break;
        case ResponseObjectTypeWordDetail:
            break;
            
        default:
            return [[[self class] alloc] initWithDictionary:aDict];
    }
    
    return [[[self class] alloc] initWithDictionary:aDict];
}

- (instancetype)initWithDictionary:(NSDictionary *)aDict {
    self = [super init];
    if (self) {
        NSMutableArray *keys = [self extractKeys];
        for (NSString *key in keys) {
            id value = [aDict objectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // 避免设置了未知 key 发生崩溃
    return;
}

- (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [NSMutableArray array];
    [keys addObject:NSStringFromSelector(@selector(success))];
    [keys addObject:NSStringFromSelector(@selector(comments))];
    return keys;
}

@end
