//
//  Footer.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Footer : UIView

@property (nonatomic, weak) IBOutlet UIButton *btnFunction;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL shouldBeBlank;

@end
