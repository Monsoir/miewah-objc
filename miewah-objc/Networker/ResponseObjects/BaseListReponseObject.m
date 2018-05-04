//
//  BaseListReponseObject.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "BaseListReponseObject.h"

@implementation BaseListReponseObject

+ (NSMutableArray<NSString *> *)extractKeys {
    NSMutableArray *keys = [BaseResponseObject extractKeys];
    [keys addObjectsFromArray:@[NSStringFromSelector(@selector(currentPageIndex)),
                                NSStringFromSelector(@selector(pages))]];
    return keys;
}

@end
