//
//  SlangDetailViewController.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const SlangDetailVCSlangKey;
extern NSString * const SlangDetailVCPronunciationKey;

@interface SlangDetailViewController : UIViewController

- (void)setWordIdentifier:(NSNumber *)identifier;
- (void)setInitialInfo:(NSDictionary *)info;

@end
