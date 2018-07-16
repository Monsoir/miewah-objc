//
//  FoundationConstants.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "FoundationConstants.h"

NSInteger const MiewahPasswordLength = 8;
NSString * const LoginCompleteNotificationName = @"LoginComplete";

const NSInteger CacheItemCount = 10;

NSString * const AssetObjectIdKey = @"objectId";
NSString * const AssetItemKey = @"item";
NSString * const AssetPronunciationKey = @"pronunciation";
NSString * const AssetMeaningKey = @"meaning";
NSString * const AssetSentencesKey = @"sentences";

NSString * const EditAssetBasicInfosFieldNames = @"BasicInfos";
NSString * const EditAssetExtraInfosFieldNames = @"ExtraInfos";
NSString * const EditAssetRecordInfosFieldNames = @"RecordInfos";

NSString * const EditAssetTypeNotificationUserInfoKey = @"EditAssetResetTypeNotificationUserInfoKey";

NSString * const EditAssetToExtraInfosEnableNotificationName = @"NewAssetToExtraInfosNotification";
NSString * const EditAssetToExtraInfosEnableNotificationUserInfoKey = @"NewAssetToExtraInfosNotificationUserInfoKey";
NSString * const EditAssetResetNotificationName = @"NewAssetResetNotification";

NSString * const EditAssetSaveBasicInfoNotificationName = @"EditAssetSaveBasicInfoNotification";
NSString * const EditAssetSaveExtraInfoNotificationName = @"EditAssetSaveExtraInfoNotification";

NSInteger const RecordDuration = 5;

//NSString * const BasicInfoItemKey = @"BasicInfoItem";
//NSString * const BasicInfoPronunonciationKey = @"BasicInfoPronunonciation";
//NSString * const BasicInfoMeaningKey = @"BasicInfoMeaning";

@implementation FoundationConstants

@end
