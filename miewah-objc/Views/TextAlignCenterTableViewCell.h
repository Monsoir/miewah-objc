//
//  TextAlignCenterTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextAlignCenterTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *lbTtitle;

+ (NSString *)reuseIdentifier;

@end
