//
//  NSDateFormatter+Singleton.h
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SharedDateFormatter [NSDateFormatter shareInstance]

@interface NSDateFormatter (Singleton)

+ (instancetype)shareInstance;

@end
