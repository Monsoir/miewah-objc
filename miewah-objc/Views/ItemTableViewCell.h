//
//  ItemTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/6/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;
@property (nonatomic, copy) NSString *updateAt;

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellHeight;

@end
