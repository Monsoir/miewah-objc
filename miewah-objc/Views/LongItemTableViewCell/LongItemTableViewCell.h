//
//  LongItemTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LongItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *lbItem;
@property (weak, nonatomic) IBOutlet UILabel *lbDetailA;
@property (weak, nonatomic) IBOutlet UILabel *lbDetailB;

+ (NSString *)reuseIdentifier;
@end
