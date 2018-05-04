//
//  BaseListReponseObject.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "BaseResponseObject.h"

@interface BaseListReponseObject : BaseResponseObject

@property (nonatomic, strong) NSNumber *currentPageIndex;
@property (nonatomic, strong) NSNumber *pages;

+ (NSMutableArray<NSString *> *)extractKeys;

@end
