//
//  ShortItemTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *lbWord;
@property (weak, nonatomic) IBOutlet UILabel *lbPronounce;
@property (weak, nonatomic) IBOutlet UILabel *lbMeaning;

+ (NSString *)reuseIdentifier;

@end
