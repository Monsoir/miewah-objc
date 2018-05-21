//
//  TextTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/18.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextTableViewCell;

@protocol TextTableViewCellDelegate
- (void)textTableViewCellTextDidChange:(TextTableViewCell *)cell text:(NSString *)text;
@end

@interface TextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTextPrompt;
@property (weak, nonatomic) IBOutlet UITextField *tfContent;

@property (nonatomic, weak) id<TextTableViewCellDelegate> delegate;

+ (NSString *)reuseIdentifier;

@end
