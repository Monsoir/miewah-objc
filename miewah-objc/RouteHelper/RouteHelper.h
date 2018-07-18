//
//  RouteHelper.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AppScheme;
extern NSString * const DoNotChangeTabKey;

/**
 路由常数
 
 应用内路由模式
 - tab: /[asset]s
 - tab-detail: /[asset]/[objectId]?item=item&pronunciation=pron
 */

@interface RouteHelper : NSObject

/* List */

/** Route pattern **/

+ (NSString *)characterListRoutePattern;
+ (NSString *)wordListRoutePattern;
+ (NSString *)slangListRoutePattern;
+ (NSString *)localAssetListRoutePattern;
+ (NSString *)localAssetConcreteListRoutePattern;

/** Route url **/

+ (NSURL *)characterListRouteURL;
+ (NSURL *)wordListRouteURL;
+ (NSURL *)slangListRouteURL;
+ (NSURL *)localAssetListRouteURL;

+ (NSString *)localAssetConcreteListRouteOfType:(NSInteger)type otherParams:(NSDictionary<NSString *, id> *)otherParams;

+ (NSURL *)localAssetConcreteListRouteURLOfType:(NSInteger)type otherParams:(NSDictionary<NSString *, id> *)otherParams;

/* Detail */

/** Route Pattern **/

+ (NSString *)characterDetailRoutePattern;
+ (NSString *)wordDetailRoutePattern;
+ (NSString *)slangDetailRoutePattern;

/** Route string **/

+ (NSString *)characterDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams;
+ (NSString *)wordDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams;
+ (NSString *)slangDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams;

/** Route url **/

+ (NSURL *)characterDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams;
+ (NSURL *)wordDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams;
+ (NSURL *)slangDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams;

@end
