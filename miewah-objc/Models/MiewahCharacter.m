//
//  MiewahCharacter.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahCharacter.h"

@implementation MiewahCharacter

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

+ (NSArray<NSString *> *)extractKeys {
    NSArray<NSString *> *keys = @[
                                  NSStringFromSelector(@selector(objectId)),
                                  NSStringFromSelector(@selector(item)),
                                  NSStringFromSelector(@selector(pronunciation)),
                                  NSStringFromSelector(@selector(meaning)),
                                  NSStringFromSelector(@selector(source)),
                                  NSStringFromSelector(@selector(inputMethods)),
                                  NSStringFromSelector(@selector(sentences)),
                                  NSStringFromSelector(@selector(pronunciationVoice)),
                                  NSStringFromSelector(@selector(createdAt)),
                                  NSStringFromSelector(@selector(updatedAt)),
                                  ];
    return keys;
}

+ (NSDictionary *)escapedKeys {
    return nil;
}

@end
