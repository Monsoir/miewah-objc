//
//  PlainTextFooter.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/17.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "PlainTextFooter.h"
#import <Masonry/Masonry.h>

@interface PlainTextFooter()

@property (nonatomic, strong) UILabel *lbTtitle;

@end

@implementation PlainTextFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addSubview:self.lbTtitle];
    
    [self.lbTtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 8, 0, 8));
    }];
}

- (void)setDetail:(NSString *)detail {
    self.lbTtitle.text = [NSString stringWithFormat:@"%@: %@", self.prompt, detail];
}

- (UILabel *)lbTtitle {
    if (_lbTtitle == nil) {
        _lbTtitle = [[UILabel alloc] init];
        _lbTtitle.numberOfLines = 1;
    }
    return _lbTtitle;
}

@end
