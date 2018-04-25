//
//  SlangItemDetailHeaderView.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlangItemDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbSlang;
@property (weak, nonatomic) IBOutlet UILabel *lbPronounce;
@property (weak, nonatomic) IBOutlet UIButton *btnPronounce;
@property (weak, nonatomic) IBOutlet UIButton *btnRecord;

@end
