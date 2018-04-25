//
//  ItemIntroductionHeader.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemIntroductionHeader : UIView

@property (nonatomic, weak) IBOutlet UILabel *lbIntroduction;

+ (NSString *)reuseIdentifier;

@end
