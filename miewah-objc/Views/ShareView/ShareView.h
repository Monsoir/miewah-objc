//
//  ShareView.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const ShareItemKey;
extern NSString * const ShareMeaningKey;
extern NSString * const ShareSentenceKey;

@interface ShareView : UIView

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo;

@end
