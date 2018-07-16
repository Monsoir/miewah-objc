//
//  NSDictionary+JoinString.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JoinString)

- (NSString *)joinBySeparator:(NSString *)separator;
- (NSString *)queryParams;

@end
