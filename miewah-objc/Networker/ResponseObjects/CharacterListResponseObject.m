//
//  CharacterListResponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterListResponseObject.h"

@implementation CharacterListResponseObject

- (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [super extractKeys];
    [keys addObjectsFromArray:@[NSStringFromSelector(@selector(characters)),
                                NSStringFromSelector(@selector(currentPageIndex)),
                                NSStringFromSelector(@selector(pages))]];
    return keys;
}

@end
