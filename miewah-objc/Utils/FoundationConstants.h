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

// 编辑时，数据的类型
extern NSString * const EditAssetTypeNotificationUserInfoKey;

// 编辑时，是否可以进行下一步
extern NSString * const EditAssetToExtraInfosEnableNotificationName;

// 编辑时，是否可以进行下一步的消息键
extern NSString * const EditAssetToExtraInfosEnableNotificationUserInfoKey;

// 编辑时，重设数据
extern NSString * const EditAssetResetNotificationName;

// 编辑时，暂存基本信息
extern NSString * const EditAssetSaveBasicInfoNotificationName;

// 编辑时，暂存额外信息
extern NSString * const EditAssetSaveExtraInfoNotificationName;

// 编辑时，暂存信息的键
//extern NSString * const BasicInfoItemKey;
//extern NSString * const BasicInfoPronunonciationKey;
//extern NSString * const BasicInfoMeaningKey;

// 沙盒读取
#define HomeDirectory NSHomeDirectory()
#define DocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define CachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define TmpDirectory NSTemporaryDirectory()

#define StandardUserDefault [NSUserDefaults standardUserDefaults]
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]

#define alwaysString(aString) aString ?: @""

typedef enum : NSUInteger {
    MiewahItemTypeCharacter,
    MiewahItemTypeWord,
    MiewahItemTypeSlang,
    MiewahItemTypeNone,
} MiewahItemType;

@interface FoundationConstants : NSObject

@end
