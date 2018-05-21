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

NSString * const EditAssetBasicInfosFieldNames = @"BasicInfos";
NSString * const EditAssetExtraInfosFieldNames = @"ExtraInfos";

NSString * const EditAssetToExtraInfosEnableNotificationName = @"NewAssetToExtraInfosNotification";
NSString * const EditAssetToExtraInfosEnableNotificationUserInfoKey = @"NewAssetToExtraInfosNotificationUserInfoKey";
NSString * const EditAssetResetNotificationName = @"NewAssetResetNotification";
NSString * const EditAssetResetTypeNotificationUserInfoKey = @"EditAssetResetTypeNotificationUserInfoKey";

@implementation FoundationConstants

@end
