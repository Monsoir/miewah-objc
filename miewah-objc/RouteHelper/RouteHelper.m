//
//  RouteHelper.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "RouteHelper.h"
#import "NSDictionary+JoinString.h"

NSString * const AppScheme = @"com.wenyongyang.miewah";
NSString * const DoNotChangeTabKey = @"do-not-change-tab";

static NSString *CharacterRouteRoot = @"character";
static NSString *WordRouteRoot = @"word";
static NSString *SlangRouteRoot = @"slang";
static NSString *LocalAssetRouteRoot = @"local-asset";

#define alwaysString(aString) aString ?: @""

@implementation RouteHelper

/* list pattern */

+ (NSString *)characterListRoutePattern {
    return [NSString stringWithFormat:@"/%@s", CharacterRouteRoot];
}

+ (NSString *)wordListRoutePattern {
    return [NSString stringWithFormat:@"/%@s", WordRouteRoot];
}

+ (NSString *)slangListRoutePattern {
    return [NSString stringWithFormat:@"/%@s", SlangRouteRoot];
}

+ (NSString *)localAssetListRoutePattern {
    return [NSString stringWithFormat:@"/%@s", LocalAssetRouteRoot];
}

/* list url */

+ (NSURL *)characterListRouteURL {
    NSString *routePattern = [self assetListRouteBuilderOfRootRoute:[self characterListRoutePattern]];
    return [NSURL URLWithString:routePattern];
}

+ (NSURL *)wordListRouteURL {
    NSString *routePattern = [self assetListRouteBuilderOfRootRoute:[self wordListRoutePattern]];
    return [NSURL URLWithString:routePattern];
}

+ (NSURL *)slangListRouteURL {
    NSString *routePattern = [self assetListRouteBuilderOfRootRoute:[self slangListRoutePattern]];
    return [NSURL URLWithString:routePattern];
}

+ (NSURL *)localAssetListRouteURL {
    NSString *routePattern = [self assetListRouteBuilderOfRootRoute:[self localAssetListRoutePattern]];
    return [NSURL URLWithString:routePattern];
}

/* detail pattern */

+ (NSString *)characterDetailRoutePattern {
    return [NSString stringWithFormat:@"/%@/:objectId", CharacterRouteRoot];
}

+ (NSString *)wordDetailRoutePattern {
    return @"/word/:objectId";
    return [NSString stringWithFormat:@"/%@/:objectId", WordRouteRoot];
}

+ (NSString *)slangDetailRoutePattern {
    return [NSString stringWithFormat:@"/%@/:objectId", SlangRouteRoot];
}

/* detail url string generators */

+ (NSString *)characterDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams {
    return [self assetDetailRouteBuilderOfRootRoute:[NSString stringWithFormat:@"/%@", CharacterRouteRoot] objectId:objectId item:item pronunciation:pronunciation otherParams:otherParams];
}

+ (NSString *)wordDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams {
    return [self assetDetailRouteBuilderOfRootRoute:[NSString stringWithFormat:@"/%@", WordRouteRoot] objectId:objectId item:item pronunciation:pronunciation otherParams:otherParams];
}

+ (NSString *)slangDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams {
    return [self assetDetailRouteBuilderOfRootRoute:[NSString stringWithFormat:@"/%@", SlangRouteRoot] objectId:objectId item:item pronunciation:pronunciation otherParams:otherParams];
}

/* detail url generators */

+ (NSURL *)characterDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams {
    NSString *pattern = [self characterDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation otherParams:otherParams];
    return [NSURL URLWithString:pattern];
}

+ (NSURL *)wordDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams {
    NSString *pattern = [self wordDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation otherParams:otherParams];
    return [NSURL URLWithString:pattern];
}

+ (NSURL *)slangDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary <NSString *, id> *)otherParams {
    NSString *pattern = [self slangDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation otherParams:otherParams];
    return [NSURL URLWithString:pattern];
}

/*** Private ***/

+ (NSString *)assetListRouteBuilderOfRootRoute:(NSString *)root {
    NSAssert(root.length > 0, @"should pass a root route");
    
    // 没错，这里只有一个 `/`
    return [NSString stringWithFormat:@"%@:/%@", AppScheme, root];
}

+ (NSString *)assetDetailRouteBuilderOfRootRoute:(NSString *)root objectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation otherParams:(NSDictionary<NSString *, id> *)otherParams {
    NSAssert(root.length > 0, @"should pass a root route");
    NSAssert(objectId.length > 0, @"should pass an object ID");
    
    // 没错，这里只有一个 `/`
    NSMutableString *mPath = [NSMutableString stringWithFormat:@"%@:/%@/%@", AppScheme, root, objectId];
    
    NSDictionary *queryParmsDict = @{
                                     @"item": alwaysString(item),
                                     @"pronunciation": alwaysString(pronunciation),
                                     };
    
    if (otherParams) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:otherParams];
        [params addEntriesFromDictionary:queryParmsDict];
        queryParmsDict = [params copy];
    }
    
    [mPath appendString:[NSString stringWithFormat:@"?%@", [queryParmsDict queryParams]]];
    return [mPath copy];
}

@end
