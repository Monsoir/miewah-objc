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

#define alwaysString(aString) aString ?: @""

@implementation RouteHelper

/* list pattern */

+ (NSString *)characterListRoutePattern {
    return @"/characters";
}

+ (NSString *)wordListRoutePattern {
    return @"/words";
}

+ (NSString *)slangListRoutePattern {
    return @"/slangs";
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

/* detail pattern */

+ (NSString *)characterDetailRoutePattern {
    return @"/character/:objectId";
}

+ (NSString *)wordDetailRoutePattern {
    return @"/word/:objectId";
}

+ (NSString *)slangDetailRoutePattern {
    return @"/slang/:objectId";
}

/* detail url string generators */

+ (NSString *)characterDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [self assetDetailRouteBuilderOfRootRoute:@"/character" objectId:objectId item:item pronunciation:pronunciation];
}

+ (NSString *)wordDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [self assetDetailRouteBuilderOfRootRoute:@"/word" objectId:objectId item:item pronunciation:pronunciation];
}

+ (NSString *)slangDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [self assetDetailRouteBuilderOfRootRoute:@"/slang" objectId:objectId item:item pronunciation:pronunciation];
}

/* detail url generators */

+ (NSURL *)characterDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    NSString *pattern = [self characterDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation];
    return [NSURL URLWithString:pattern];
}

+ (NSURL *)wordDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    NSString *pattern = [self wordDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation];
    return [NSURL URLWithString:pattern];
}

+ (NSURL *)slangDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    NSString *pattern = [self slangDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation];
    return [NSURL URLWithString:pattern];
}

/*** Private ***/

+ (NSString *)assetListRouteBuilderOfRootRoute:(NSString *)root {
    NSAssert(root.length > 0, @"should pass a root route");
    
    // 没错，这里只有一个 `/`
    return [NSString stringWithFormat:@"%@:/%@", AppScheme, root];
}

+ (NSString *)assetDetailRouteBuilderOfRootRoute:(NSString *)root objectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    NSAssert(root.length > 0, @"should pass a root route");
    NSAssert(objectId.length > 0, @"should pass an object ID");
    
    // 没错，这里只有一个 `/`
    NSMutableString *mPath = [NSMutableString stringWithFormat:@"%@:/%@/%@", AppScheme, root, objectId];
    
    NSDictionary *queryParmsDict = @{
                                     @"item": alwaysString(item),
                                     @"pronunciation": alwaysString(pronunciation),
                                     };
    [mPath appendString:[NSString stringWithFormat:@"?%@", [queryParmsDict queryParams]]];
    return [mPath copy];
}

@end
