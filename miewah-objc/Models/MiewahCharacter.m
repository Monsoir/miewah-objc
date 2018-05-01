//
//  MiewahCharacter.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahCharacter.h"

@implementation MiewahCharacter

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

+ (NSArray<NSString *> *)extractKeys {
    NSArray<NSString *> *keys = @[
                                  NSStringFromSelector(@selector(character)),
                                  NSStringFromSelector(@selector(pronunciation)),
                                  NSStringFromSelector(@selector(meaning)),
                                  NSStringFromSelector(@selector(inputMethods)),
                                  NSStringFromSelector(@selector(sentences)),
                                  NSStringFromSelector(@selector(pronunciationVoice)),
                                  ];
    return keys;
}

+ (NSDictionary *)escapedKeys {
    NSDictionary *dict = @{@"id": NSStringFromSelector(@selector(identifier))};
    return dict;
}

@end
