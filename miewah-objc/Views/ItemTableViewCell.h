//
//  ItemTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/6/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) UILabel *lbItem;
@property (strong, nonatomic, readonly) UILabel *lbDetailA;
@property (strong, nonatomic, readonly) UILabel *lbDetailB;

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellHeight;

@end
