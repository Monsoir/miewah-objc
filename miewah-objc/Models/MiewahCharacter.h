//
//  MiewahCharacter.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahAsset.h"
#import "InputMethod.h"

@interface MiewahCharacter : MiewahAsset

@property (nonatomic, copy) NSString *inputMethods;
@property (nonatomic, copy) NSString *pronunciationVoice;

- (NSDictionary *)deSerializeInputMethods;

/**
 将输入法模型 JSON 数据转换成阅读友好的格式

 @return 阅读友好的输入法字典
 */
- (NSDictionary<NSString *, NSArray<InputMethod *> *> *)organizedInputMethods;

@end
