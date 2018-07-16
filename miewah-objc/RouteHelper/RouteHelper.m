//
//  RouteHelper.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "RouteHelper.h"
#import "NSDictionary+JoinString.h"

#define alwaysString(aString) aString ?: @""

@implementation RouteHelper

+ (NSString *)characterListRoute {
    return @"/characters";
}

+ (NSString *)wordListRoute {
    return @"/words";
}

+ (NSString *)slangListRoute {
    return @"/slangs";
}

+ (NSURL *)characterListRouteURL {
    return [NSURL URLWithString:[self characterListRoute]];
}

+ (NSURL *)wordListRouteURL {
    return [NSURL URLWithString:[self wordListRoute]];
}

+ (NSURL *)slangListRouteURL {
    return [NSURL URLWithString:[self slangListRoute]];
}

+ (NSString *)characterDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [self assetDetailRouteBuilderOfRootRoute:@"/character" objectId:objectId item:item pronunciation:pronunciation];
}

+ (NSString *)wordDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [self assetDetailRouteBuilderOfRootRoute:@"/word" objectId:objectId item:item pronunciation:pronunciation];
}

+ (NSString *)slangDetailRouteOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [self assetDetailRouteBuilderOfRootRoute:@"/slang" objectId:objectId item:item pronunciation:pronunciation];
}

+ (NSURL *)characterDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [NSURL URLWithString:[self characterDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation]];
}

+ (NSURL *)wordDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [NSURL URLWithString:[self wordDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation]];
}

+ (NSURL *)slangDetailRouteURLOfObjectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    return [NSURL URLWithString:[self slangDetailRouteOfObjectId:objectId item:item pronunciation:pronunciation]];
}

/*** Private ***/

+ (NSString *)assetDetailRouteBuilderOfRootRoute:(NSString *)root objectId:(NSString *)objectId item:(NSString *)item pronunciation:(NSString *)pronunciation {
    NSAssert(root.length > 0, @"should pass a root route");
    NSAssert(objectId.length > 0, @"should pass an object ID");
    
    NSMutableString *mPath = [NSMutableString stringWithFormat:@"%@/%@", root, objectId];
    
    NSDictionary *queryParmsDict = @{
                                     @"item": alwaysString(item),
                                     @"pronunciation": alwaysString(pronunciation),
                                     };
    [mPath appendString:[NSString stringWithFormat:@"?%@", [queryParmsDict queryParams]]];
    return [mPath copy];
}

@end
