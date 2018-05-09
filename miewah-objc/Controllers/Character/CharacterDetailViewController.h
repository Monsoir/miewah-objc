//
//  CharacterViewController.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CharacterDetailVCWordKey;
extern NSString * const CharacterDetailVCPronunciationKey;

@interface CharacterDetailViewController : UIViewController

- (void)setCharacterIdentifier:(NSString *)identifier;
- (void)setInitialInfo:(NSDictionary *)info;

@end
