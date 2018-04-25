//
//  Footer.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "Footer.h"

@implementation Footer

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.btnFunction setTitle:_title forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self.btnFunction setTitleColor:_textColor forState:UIControlStateNormal];
}

- (void)setShouldBeBlank:(BOOL)shouldBeBlank {
    _shouldBeBlank = shouldBeBlank;
    [self.btnFunction setHidden:_shouldBeBlank];
}

@end
