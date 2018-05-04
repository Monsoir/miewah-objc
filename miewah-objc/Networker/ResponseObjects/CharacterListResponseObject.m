//
//  CharacterListResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterListResponseObject.h"

@implementation CharacterListResponseObject

+ (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseResponseObject extractKeys];
    [keys addObjectsFromArray:@[NSStringFromSelector(@selector(characters))]];
    return keys;
}

@end
