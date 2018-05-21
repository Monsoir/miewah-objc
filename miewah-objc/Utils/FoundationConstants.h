//
//  FoundationConstants.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger MiewahPasswordLength;
extern NSString * const LoginCompleteNotificationName;

// 编辑时的表单字段可视化名称
extern NSString * const EditAssetBasicInfosFieldNames;
extern NSString * const EditAssetExtraInfosFieldNames;

// 编辑时，是否可以进行下一步
extern NSString * const EditAssetToExtraInfosEnableNotificationName;

// 编辑时，是否可以进行下一步的消息键
extern NSString * const EditAssetToExtraInfosEnableNotificationUserInfoKey;

// 编辑时，重设数据
extern NSString * const EditAssetResetNotificationName;

// 编辑时，重设数据时的类型
extern NSString * const EditAssetResetTypeNotificationUserInfoKey;

#define StandardUserDefault [NSUserDefaults standardUserDefaults]
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]

typedef enum : NSUInteger {
    MiewahItemTypeCharacter,
    MiewahItemTypeWord,
    MiewahItemTypeSlang,
    MiewahItemTypeNone,
} MiewahItemType;

@interface FoundationConstants : NSObject

@end
