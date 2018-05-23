//
//  EditPreviewViewHeader.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPreviewViewHeader : UIView

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *prononuciation;

+ (CGFloat)height;

@end
