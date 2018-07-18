//
//  RouteHelperTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RouteHelper.h"
#import "FoundationConstants.h"
#import "NSDictionary+JoinString.h"

@interface RouteHelperTests : XCTestCase

@end

@implementation RouteHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCharacterListRoutePattern {
    NSAssert([[RouteHelper characterListRoutePattern] isEqualToString:@"/characters"], @"");
}

- (void)testWordListRoutePattern {
    NSAssert([[RouteHelper wordListRoutePattern] isEqualToString:@"/words"], @"");
}

- (void)testSlangListRoutePattern {
    NSAssert([[RouteHelper slangListRoutePattern] isEqualToString:@"/slangs"], @"");
}

- (void)testLocalAssetListRoutePattern {
    NSAssert([[RouteHelper localAssetListRoutePattern] isEqualToString:@"/local-assets"], @"");
}

- (void)testLocalAssetConcreteListRoutePattern {
    NSAssert([[RouteHelper localAssetConcreteListRoutePattern] isEqualToString:@"/local-asset-concrete-list/:type"], @"");
}


- (void)testCharacterListRouteURL {
    NSURL *url = [RouteHelper characterListRouteURL];
    NSAssert([url isKindOfClass:[NSURL class]], @"The character list route url is not an instance of NSURL");
    
    NSString *expectedString = [NSString stringWithFormat:@"%@://characters", AppScheme];
    NSAssert([[url absoluteString] isEqualToString:expectedString], @"The character list url string is not right");
}

- (void)testWordListRouteURL {
    NSURL *url = [RouteHelper wordListRouteURL];
    NSAssert([url isKindOfClass:[NSURL class]], @"The word list route url is not an instance of NSURL");
    
    NSString *expectedString = [NSString stringWithFormat:@"%@://words", AppScheme];
    NSAssert([[url absoluteString] isEqualToString:expectedString], @"The word list url string is not right");
}

- (void)testSlangListRouteURL {
    NSURL *url = [RouteHelper slangListRouteURL];
    NSAssert([url isKindOfClass:[url class]], @"The slang list route url is not an instance of NSURL");
    
    NSString *expectedString = [NSString stringWithFormat:@"%@://slangs", AppScheme];
    NSAssert([[url absoluteString] isEqualToString:expectedString], @"The slang list url string is not right");
}

- (void)testLocalAssetListRouteURL {
    NSURL *url = [RouteHelper localAssetListRouteURL];
    NSAssert([url isKindOfClass:[url class]], @"The local asset list route url is not an instance of NSURL");
    
    NSString *expectingString = [NSString stringWithFormat:@"%@://local-assets", AppScheme];
    NSAssert([[url absoluteString] isEqualToString:expectingString], @"The local asset list route url string is not right");
}

- (void)testCharacterDetailRouteWithOtherParams {
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    [queryParams addEntriesFromDictionary:otherParams];
    NSString *url = [RouteHelper characterDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:otherParams];
    NSString *correct = [NSString stringWithFormat:@"%@://character/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isEqualToString:correct], @"The character detail route with other params is not right");
}

- (void)testCharacterDetailRouteWithoutOtherParams {
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    NSString *url = [RouteHelper characterDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:nil];
    NSString *correct = [NSString stringWithFormat:@"%@://character/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isEqualToString:correct], @"The character detail route without other params is not right");
}

- (void)testWordDetailRouteWithOtherParams {
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    [queryParams addEntriesFromDictionary:otherParams];
    NSString *url = [RouteHelper wordDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:otherParams];
    NSString *correct = [NSString stringWithFormat:@"%@://word/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isEqualToString:correct], @"The word detail route with other params is not right");
}

- (void)testWordDetailRouteWithoutOtherParams {
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    NSString *url = [RouteHelper wordDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:nil];
    NSString *correct = [NSString stringWithFormat:@"%@://word/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isEqualToString:correct], @"The word detail route without other params is not right");
}

- (void)testSlangDetailRouteWithOtherParams {
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    [queryParams addEntriesFromDictionary:otherParams];
    NSString *url = [RouteHelper slangDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:otherParams];
    NSString *correct = [NSString stringWithFormat:@"%@://slang/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isEqualToString:correct], @"The slang detail route with other params is not right");
}

- (void)testSlangDetailRouteWithoutOtherParams {
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    NSString *url = [RouteHelper slangDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:nil];
    NSString *correct = [NSString stringWithFormat:@"%@://slang/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isEqualToString:correct], @"The slang detail route without other params is not right");
}

- (void)testLocalAssetConcreteListRouteWithOtherParams {
    NSDictionary *params = @{
                             DoNotChangeTabKey: @(YES),
                             };
    NSString *url = [RouteHelper localAssetConcreteListRouteOfType:1 otherParams:params];
    NSString *correct = [NSString stringWithFormat:@"%@://local-asset-concrete-list/1?do-not-change-tab=1", AppScheme];
    NSAssert([url isEqualToString:correct], @"The concrete list detail route with other params is not right");
}

- (void)testLocalAssetConcreteListRouteWithoutOtherParams {
    NSString *url = [RouteHelper localAssetConcreteListRouteOfType:1 otherParams:nil];
    NSString *correct = [NSString stringWithFormat:@"%@://local-asset-concrete-list/1", AppScheme];
    NSAssert([url isEqualToString:correct], @"The concrete list detail route without other params is not right");
}

- (void)testCharacterDetailRouteURLWithOtherParams {
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    [queryParams addEntriesFromDictionary:otherParams];
    NSURL *url = [RouteHelper characterDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:otherParams];
    NSString *correct = [NSString stringWithFormat:@"%@://character/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isKindOfClass:[NSURL class]], @"The character detail route url with other params is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct], @"The character route url with other params is not right");
}

- (void)testCharacterDetailRouteURLWithoutOtherParams {
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    NSURL *url = [RouteHelper characterDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:nil];
    NSString *correct = [NSString stringWithFormat:@"%@://character/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isKindOfClass:[NSURL class]], @"The character detail route url without other params is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct], @"The character route url without other params is not right");
}

- (void)testWordDetailRouteURLWithOtherParams {
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    [queryParams addEntriesFromDictionary:otherParams];
    NSURL *url = [RouteHelper wordDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:otherParams];
    NSString *correct = [NSString stringWithFormat:@"%@://word/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isKindOfClass:[NSURL class]], @"The word detail route url with other params is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct], @"The word route url with other params is not right");
}

- (void)testWordDetailRouteURLWithoutOtherParams {
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    NSURL *url = [RouteHelper wordDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:nil];
    NSString *correct1 = [NSString stringWithFormat:@"%@://word/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isKindOfClass:[NSURL class]], @"The word detail route url without other params is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct1], @"The word route url without other params is not right");
}

- (void)testSlangDetailRouteURLWithOtherParams {
    NSDictionary *otherParams = @{
                                  DoNotChangeTabKey: @(YES),
                                  };
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    [queryParams addEntriesFromDictionary:otherParams];
    NSURL *url = [RouteHelper slangDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:otherParams];
    NSString *correct = [NSString stringWithFormat:@"%@://slang/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isKindOfClass:[NSURL class]], @"The slang detail route url with other params is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct], @"The slang route url with other params is not right");
}

- (void)testSlangDetailRouteURLWithoutOtherParams {
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       AssetPronunciationKey: @"efg",
                                                                                       AssetItemKey: @"abc",
                                                                                       }];
    NSURL *url = [RouteHelper slangDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg" otherParams:nil];
    NSString *correct = [NSString stringWithFormat:@"%@://slang/123?%@", AppScheme, [[queryParams copy] queryParams]];
    NSAssert([url isKindOfClass:[NSURL class]], @"The slang detail route url without other params is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct], @"The slang route url without other params is not right");
}

- (void)testLocalAssetConcreteListRouteURLWithOtherParams {
    NSDictionary *params = @{
                             DoNotChangeTabKey: @(YES),
                             };
    NSURL *url = [RouteHelper localAssetConcreteListRouteURLOfType:1 otherParams:params];
    NSAssert([url isKindOfClass:[NSURL class]], @"The concrete list route url with other params is not an instance of NSURL");
    
    NSString *correct = [NSString stringWithFormat:@"%@://local-asset-concrete-list/1?do-not-change-tab=1", AppScheme];
    NSAssert([[url absoluteString] isEqualToString:correct], @"The concrete list detail route with other params is not right");
}

- (void)testLocalAssetConcreteListRouteURLWithoutOtherParams {
    NSURL *url = [RouteHelper localAssetConcreteListRouteURLOfType:1 otherParams:nil];
    NSAssert([url isKindOfClass:[NSURL class]], @"The concrete list route url with other params is not an instance of NSURL");
    
    NSString *correct = [NSString stringWithFormat:@"%@://local-asset-concrete-list/1", AppScheme];
    NSAssert([[url absoluteString] isEqualToString:correct], @"The concrete list detail route without other params is not right");
}

@end
