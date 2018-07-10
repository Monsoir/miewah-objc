//
//  NSObject+Property.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/10.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

+ (NSSet<NSString *> *)propertiesListInheritedFromClass:(Class)aClass {
    NSMutableSet *properties = [NSMutableSet set];
    
    if (aClass == nil) {
        [self properties:&properties OfClass:[self class]];
    } else {
        Class observing = [self class];
        while ([observing isSubclassOfClass:aClass]) {
            [self properties:&properties OfClass:observing];
            observing = [observing superclass];
        }
    }
    
    return [properties copy];
}

+ (void)properties:(NSMutableSet **)set OfClass:(Class)aClass {
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(aClass, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *objcStyleName = [NSString stringWithUTF8String:name];
        [*set addObject:objcStyleName];
    }
    free(properties);
}

@end
