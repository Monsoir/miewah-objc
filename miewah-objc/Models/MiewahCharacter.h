//
//  MiewahCharacter.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahAsset.h"

@interface MiewahCharacter : MiewahAsset

@property (nonatomic, copy) NSString *inputMethods;
@property (nonatomic, copy) NSString *pronunciationVoice;

- (NSDictionary *)deSerializeInputMethods;
- (NSString *)prettifiedInputMethods;

@end
