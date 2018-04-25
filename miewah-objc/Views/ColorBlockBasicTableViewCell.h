//
//  ColorBlockBasicTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorBlockBasicTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *colorLeader;
@property (nonatomic, weak) IBOutlet UILabel *lbTitle;

+ (NSString *)reuseIdentifier;

@end
