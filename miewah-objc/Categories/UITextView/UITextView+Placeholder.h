//
//  UITextView+Placeholder.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)

@property (nonatomic, copy, readonly) NSString *realText;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;
- (void)setPlaceholder:(NSString *)placeholder shouldSet:(BOOL)shouldSet;

@end
