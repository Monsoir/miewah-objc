//
//  UITextView+Placeholder.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

@interface UITextView (Private)
@property (nonatomic, assign) BOOL needPlaceholder;
@property (nonatomic, copy) NSString *placeholder;
@end

@implementation UITextView (Private)

@dynamic placeholder;
static char placeholderKey;

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &placeholderKey, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, &placeholderKey);
}

@dynamic needPlaceholder;
static char needPlaceholderKey;

- (void)setNeedPlaceholder:(BOOL)needPlaceholder {
    objc_setAssociatedObject(self, &needPlaceholderKey, @(needPlaceholder), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)needPlaceholder {
    return [objc_getAssociatedObject(self, &needPlaceholderKey) boolValue];
}

@end

@implementation UITextView (Placeholder)

- (instancetype)initWithPlaceholder:(NSString *)placeholder {
    self = [self init];
    if (self) {
        self.placeholder = placeholder;
    }
    return self;
}

- (void)dealloc {
}

- (void)setPlaceholder:(NSString *)placeholder shouldSet:(BOOL)shouldSet {
    self.needPlaceholder = shouldSet;
    if (self.needPlaceholder) {
        self.placeholder = placeholder;
    } else {
        self.placeholder = @"";
    }
}

- (NSString *)realText {
    if (self.needPlaceholder && self.textColor == [UIColor lightGrayColor]) {
        return @"";
    } else {
        return self.text;
    }
}

@end
