//
//  RouteHelper.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 路由常数
 
 应用内路由模式
 - tab: /[asset]s
 - tab-detail: /[asset]/[objectId]?item=item&pronunciation=pron
 */

@interface RouteHelper : NSObject

/* List */

/** Route string **/

+ (NSString *)characterListRoute;
+ (NSString *)wordListRoute;
+ (NSString *)slangListRoute;

/** Route url **/

+ (NSURL *)characterListRouteURL;
+ (NSURL *)wordListRouteURL;
+ (NSURL *)slangListRouteURL;

/* Detail */

/** Route string **/

+ (NSString *)characterDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation;
+ (NSString *)wordDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation;
+ (NSString *)slangDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation;

/** Route url **/

+ (NSURL *)characterDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation;
+ (NSURL *)wordDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation;
+ (NSURL *)slangDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation;

@end
