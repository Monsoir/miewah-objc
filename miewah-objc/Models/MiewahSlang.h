//
//  MiewahSlang.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahModel.h"

@interface MiewahSlang : MiewahModel

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, copy) NSString *slang;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sentences;
@property (nonatomic, copy) NSString *pronunciationVoice;

@end
