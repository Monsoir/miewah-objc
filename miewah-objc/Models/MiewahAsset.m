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
#import "DatetimeHelper.h"
#import <objc/runtime.h>

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
    return [NSString stringWithFormat:@"objectId:%@\nitem:%@\npronunciation: %@\nmeaning: %@\nsource:%@\nsentences:%@", self.objectId, self.item, self.pronunciation, self.meaning, self.source, self.sentences];
}

@end

@implementation MiewahAsset(Datetime)

- (NSString *)normalFormatCreatedAt {
    return [DatetimeHelper convertISODate2NormalFormatDate:self.createdAt];
}

- (NSString *)normalFormatUpdatedAt {
    return [DatetimeHelper convertISODate2NormalFormatDate:self.updatedAt];
}

@end
