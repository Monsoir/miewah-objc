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
#import "WordListResponseObject.h"
#import "WordDetailResponseObject.h"

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
            return [[WordListResponseObject alloc] initWithDictionary:aDict];
        case ResponseObjectTypeWordDetail:
            return [[WordDetailResponseObject alloc] initWithDictionary:aDict];
            
        default:
#if DEBUG
            NSLog(@"%@: Attention!!!!\nYou might forgot to SET THE CORRECT RESPONSE OBJECT!!!", [self class]);
#endif
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
#if DEBUG
    NSLog(@"%@ setting undefined key...", [self class]);
#endif
    return;
}

- (id)valueForUndefinedKey:(NSString *)key {
#if DEBUG
    NSLog(@"%@ setting undefined key...", [self class]);
#endif
    return nil;
}

- (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [NSMutableArray array];
    [keys addObject:NSStringFromSelector(@selector(success))];
    [keys addObject:NSStringFromSelector(@selector(comments))];
    return keys;
}

@end
