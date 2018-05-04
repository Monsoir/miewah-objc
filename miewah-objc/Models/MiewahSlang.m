//
//  MiewahSlang.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahSlang.h"

@implementation MiewahSlang

+ (NSArray<NSString *> *)extractKeys {
    NSArray<NSString *> *keys = @[
                                  NSStringFromSelector(@selector(slang)),
                                  NSStringFromSelector(@selector(pronunciation)),
                                  NSStringFromSelector(@selector(meaning)),
                                  NSStringFromSelector(@selector(source)),
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
