//
//  WordListResponseObject.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "BaseResponseObject.h"

@interface WordListResponseObject : BaseResponseObject

@property (nonatomic, strong) id words;
@property (nonatomic, strong) NSNumber *currentPageIndex;
@property (nonatomic, strong) NSNumber *pages;

@end
