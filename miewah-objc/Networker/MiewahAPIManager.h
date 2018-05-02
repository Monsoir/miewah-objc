//
//  MiewahAPIManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiewahAPIManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)registerURL;
- (NSString *)loginURL;

- (NSString *)charactersURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)characterDetailOfIdentifier:(NSString *)identifier;

- (NSString *)wordsURLWithPageIndex:(NSInteger)pageIndex;

@end
