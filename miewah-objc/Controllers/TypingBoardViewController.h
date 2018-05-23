//
//  TypingBoardViewController.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TypingBoardCompletion)(NSString *content);

@interface TypingBoardViewController : UIViewController

@property (nonatomic, copy) TypingBoardCompletion completion;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;
- (void)setContent:(NSString *)content;

@end
