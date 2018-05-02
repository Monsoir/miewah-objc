//
//  MiewahModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahModel.h"

@implementation MiewahModel

- (instancetype)initWithDictionary:(NSDictionary *)aDict {
    self = [super init];
    if (self) {
        NSArray<NSString *> *keys = [[self class] extractKeys];
        [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setValue:[aDict valueForKey:obj] forKey:obj];
        }];
        
        NSDictionary *escapedKeys = [[self class] escapedKeys];
        [escapedKeys enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:[aDict valueForKey:key] forKey:obj];
        }];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
#if DEBUG
    NSLog(@"%@ is setting undefined key", [self class]);
#endif
    return;
}

- (id)valueForUndefinedKey:(NSString *)key {
#if DEBUG
    NSLog(@"%@ is reading an undefined key...", [self class]);
#endif
    return nil;
}

+ (NSArray<NSString *> *)extractKeys {
    return nil;
}

+ (NSDictionary *)escapedKeys {
    return nil;
}

@end
