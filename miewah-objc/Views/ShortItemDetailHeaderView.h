//
//  ShortItemDetailHeaderView.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShortItemDetailHeaderAccessoriesDelegate

- (void)headerPronuns;
- (void)headerRecord;

@end

@interface ShortItemDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbWord;
@property (weak, nonatomic) IBOutlet UILabel *lbPronounce;
@property (weak, nonatomic) IBOutlet UIButton *btnPronounce;
@property (weak, nonatomic) IBOutlet UIButton *btnRecord;

@property (nonatomic, weak) id<ShortItemDetailHeaderAccessoriesDelegate> delegate;

@end
