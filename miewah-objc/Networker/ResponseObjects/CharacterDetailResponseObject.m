//
//  WordDetailResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterDetailResponseObject.h"

@implementation CharacterDetailResponseObject

- (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [super extractKeys];
    [keys addObjectsFromArray:@[
                                NSStringFromSelector(@selector(character))
                                ]];
    return keys;
}

@end
