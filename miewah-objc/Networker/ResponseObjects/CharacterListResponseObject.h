//
//  CharacterListResponseObject.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "BaseResponseObject.h"

@interface CharacterListResponseObject : BaseResponseObject

@property (nonatomic, strong) id characters;
@property (nonatomic, strong) NSNumber *currentPageIndex;
@property (nonatomic, strong) NSNumber *pages;

@end
