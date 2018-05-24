//
//  MiewahAPIManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiewahAPIManager : NSObject

#define SharedAPIManager [MiewahAPIManager sharedManager]

+ (instancetype)sharedManager;

- (NSString *)registerURL;
- (NSString *)loginURL;

- (NSString *)charactersURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)characterDetailOfIdentifier:(NSNumber *)identifier;
- (NSString *)newCharacter;

- (NSString *)wordsURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)wordDetailOfIdentifier:(NSNumber *)identifier;
- (NSString *)newWord;

- (NSString *)slangsURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)slangDetailOfIdentifier:(NSNumber *)identifier;
- (NSString *)newSlang;

@end
