//
//  PlainTextFooter.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/17.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlainTextFooter : UIView

@property (nonatomic, strong, readonly) UILabel *lbTtitle;
@property (nonatomic, copy) NSString *prompt;

- (void)setDetail:(NSString *)detail;

@end
