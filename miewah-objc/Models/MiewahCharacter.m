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

- (NSDictionary *)deSerializeInputMethods {
    if (!self.inputMethods) return nil;
    
    NSData *inputMethodData = [self.inputMethods dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *inputMethodJSONObject = [NSJSONSerialization JSONObjectWithData:inputMethodData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
#if DEBUG
        NSLog(@"%@ input method string prettify failed", [self class]);
#endif
        return nil;
    }
    
    return inputMethodJSONObject;
}

- (NSString *)prettifiedInputMethods {
    NSDictionary *inputMethodJSON = [self deSerializeInputMethods];
    if (inputMethodJSON == nil) return nil;
    
    NSMutableArray<NSString *> *methods = [NSMutableArray array];
    [inputMethodJSON enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [methods addObject: [NSString stringWithFormat:@"%@: %@", key, obj]];
    }];
    
    return [methods componentsJoinedByString:@"\n"];
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
