//
//  LeanCloudAPIManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SharedLeanCloudAPIManager [LeanCloudAPIManager sharedManager]

@interface LeanCloudAPIManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)characterListURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)characterDetailOfIdentifier:(NSString *)identifier;

- (NSString *)wordListURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)wordDetailOfIdentifier:(NSString *)identifier;

- (NSString *)slangListURLWithPageIndex:(NSInteger)pageIndex;
- (NSString *)slangDetailOfIdentifier:(NSString *)identifier;

@end
