//
//  TextPlaceholderView.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextPlaceholderView : UITextView

@property (nonatomic, copy, readonly) NSString *realText;
@property (nonatomic, copy) NSString *placeholder;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;
- (void)setInitialContent:(NSString *)initialContent;

@end
