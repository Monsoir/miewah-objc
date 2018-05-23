//
//  EditViewController.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundationConstants.h"

@interface EditViewController : UIViewController

@property (nonatomic, strong, readonly) NSDictionary *newCharacterFieldNames;

- (void)setItemType:(MiewahItemType)itemType;

@end
