//
//  TextTableViewCell.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/18.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "TextTableViewCell.h"
#import "UIView+Border.h"

@interface TextTableViewCell()

@end

@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self initialize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", NSStringFromClass([self class]));
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.tfContent];
}

- (void)initialize {
    self.tfContent.borderStyle = UITextBorderStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.tfContent];
}

- (void)textFieldDidChange:(NSNotification *)notif {
    if (self.delegate) {
        [self.delegate textTableViewCellTextDidChange:self text:[notif.object text]];
    }
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
