//
//  TextPlaceholderView.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "TextPlaceholderView.h"

@implementation TextPlaceholderView

- (instancetype)initWithPlaceholder:(NSString *)placeholder {
    self = [super init];
    if (self) {
        _placeholder = placeholder;
        self.textColor = UIColor.lightGrayColor;
        self.text = _placeholder;
        self.font = [UIFont systemFontOfSize:18];
        self.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextViewBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextViewEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    return self;
}

- (void)handleTextViewBeginEditing:(NSNotification *)notif {
    id sender = notif.object;
    if (sender != self) return;
    
    if (self.placeholder.length > 0 && self.textColor == UIColor.lightGrayColor) {
        self.text = nil;
        self.textColor = UIColor.blackColor;
    }
}

- (void)handleTextViewEndEditing:(NSNotification *)notif {
    id sender = notif.object;
    if (sender != self) return;
    
    if (self.placeholder.length > 0 && self.text.length == 0) {
        self.textColor = UIColor.lightGrayColor;
        self.text = self.placeholder;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if DEBUG
    NSLog(@"%@ deallocs", NSStringFromClass([self class]));
#endif
}

- (void)setInitialContent:(NSString *)initialContent {
    if (initialContent.length <= 0) return;
    self.text = initialContent;
    self.textColor = UIColor.blackColor;
}

- (NSString *)realText {
    if (self.placeholder.length > 0 && self.textColor == UIColor.lightGrayColor) {
        return @"";
    } else {
        return self.text;
    }
}

@end
