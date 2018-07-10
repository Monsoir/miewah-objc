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

+ (NSSet<NSString *> *)propertyList {
    NSMutableSet *propertyNames = [NSMutableSet set];
    
    // 获取父类中的属性，这里指 MiewahAsset
    {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList([[self class] superclass], &propertyCount);
        
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *objcStyleName = [NSString stringWithUTF8String:name];
            [propertyNames addObject:objcStyleName];
        }
        free(properties);
    }
    
    // 获取本类中的属性，这里指运行时，具体到的类
    // 即 MiewahCharacter, MiewahWord, MiewahSlang
    {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *objcStyleName = [NSString stringWithUTF8String:name];
            [propertyNames addObject:objcStyleName];
        }
        free(properties);
    }
    
    return [propertyNames copy];
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
