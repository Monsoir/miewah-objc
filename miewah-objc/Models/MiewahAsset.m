//
//  MiewahAsset.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahAsset.h"
#import "MiewahCharacter.h"
#import "MiewahWord.h"
#import "MiewahSlang.h"

@implementation MiewahAsset

+ (MiewahAsset *)assetOfType:(MiewahItemType)type {
    switch (type) {
        case MiewahItemTypeCharacter:
            return [[MiewahCharacter alloc] init];
        case MiewahItemTypeWord:
            return [[MiewahWord alloc] init];
        case MiewahItemTypeSlang:
            return [[MiewahSlang alloc] init];
        case MiewahItemTypeNone:
            return nil;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"item:%@\npronunciation: %@\nmeaning: %@\nsource:%@\nsentences:%@", self.item, self.pronunciation, self.meaning, self.source, self.sentences];
}

@end
