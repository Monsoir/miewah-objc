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

- (NSDictionary<NSString *, NSArray<InputMethod *> *> *)organizedInputMethods {
    NSDictionary *inputMethods = [self deSerializeInputMethods];
    if (inputMethods == nil) return nil;
    
    /**
     输入法 JSON 模型
     
     {
         macOS: [
             {
                 inputMethodCode: 'native',
                 input: 'mie',
             },
             {
                 inputMethodCode: 'sogou',
                 input: 'mie',
             },
         ],
         Windows: [
             {
                 inputMethodCode: 'microsoft-pinyin',
                 input: 'mie',
             },
             {
                 inputMethodCode: 'sogou',
                 input: 'mie',
             },
             {
                 inputMethodCode: 'bing',
                 input: 'mie',
             },
         ],
     }
     */
    
    NSMutableDictionary<NSString *, NSArray<InputMethod *> *> *methods = [NSMutableDictionary dictionary];
    NSMutableArray *temp = [NSMutableArray array];
    [inputMethods enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray * _Nonnull obj, BOOL * _Nonnull stop) {
        [temp removeAllObjects];
        for (NSDictionary *info in obj) {
            NSString *code = [info objectForKey:InputMethodCodeKey];
            NSString *name = [info objectForKey:InputMethodNameKey];
            NSString *input = [info objectForKey:InputMethodInputKey];
            InputMethod *i = [InputMethod inputMethodWithCode:code name:name input:input];
            [temp addObject:i];
        }
        methods[key] = [temp copy];
    }];
    return [methods copy];
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
