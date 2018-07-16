//
//  RouteHelperTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RouteHelper.h"

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

- (void)testCharacterDetailRoute {
    NSString *url = [RouteHelper characterDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg"];
    NSString *correct1 = [NSString stringWithFormat:@"%@://character/123?item=abc&pronunciation=efg", AppScheme];
    NSString *correct2 = [NSString stringWithFormat:@"%@://character/123?pronunciation=efg&item=abc", AppScheme];
    NSAssert([url isEqualToString:correct1] || [url isEqualToString:correct2], @"The character detail route is not right");
}

- (void)testWordDetailRoute {
    NSString *url = [RouteHelper wordDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg"];
    NSString *correct1 = [NSString stringWithFormat:@"%@://word/123?item=abc&pronunciation=efg", AppScheme];
    NSString *correct2 = [NSString stringWithFormat:@"%@://word/123?pronunciation=efg&item=abc", AppScheme];
    NSAssert([url isEqualToString:correct1] || [url isEqualToString:correct2], @"The word detail route is not right");
}

- (void)testSlangDetailRoute {
    NSString *url = [RouteHelper slangDetailRouteOfObjectId:@"123" item:@"abc" pronunciation:@"efg"];
    NSString *correct1 = [NSString stringWithFormat:@"%@://slang/123?item=abc&pronunciation=efg", AppScheme];
    NSString *correct2 = [NSString stringWithFormat:@"%@://slang/123?pronunciation=efg&item=abc", AppScheme];
    NSAssert([url isEqualToString:correct1] || [url isEqualToString:correct2], @"The slang detail route is not right");
}

- (void)testCharacterDetailRouteURL {
    NSURL *url = [RouteHelper characterDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg"];
    NSString *correct1 = [NSString stringWithFormat:@"%@://character/123?item=abc&pronunciation=efg", AppScheme];
    NSString *correct2 = [NSString stringWithFormat:@"%@://character/123?pronunciation=efg&item=abc", AppScheme];
    NSAssert([url isKindOfClass:[NSURL class]], @"The character detail route url is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct1] || [[url absoluteString] isEqualToString:correct2], @"The character route url is not right");
}

- (void)testWordDetailRouteURL {
    NSURL *url = [RouteHelper wordDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg"];
    NSString *correct1 = [NSString stringWithFormat:@"%@://word/123?item=abc&pronunciation=efg", AppScheme];
    NSString *correct2 = [NSString stringWithFormat:@"%@://word/123?pronunciation=efg&item=abc", AppScheme];
    NSAssert([url isKindOfClass:[NSURL class]], @"The word detail route url is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct1] || [[url absoluteString] isEqualToString:correct2], @"The word route url is not right");
}

- (void)testSlangDetailRouteURL {
    NSURL *url = [RouteHelper slangDetailRouteURLOfObjectId:@"123" item:@"abc" pronunciation:@"efg"];
    NSString *correct1 = [NSString stringWithFormat:@"%@://slang/123?item=abc&pronunciation=efg", AppScheme];
    NSString *correct2 = [NSString stringWithFormat:@"%@://slang/123?pronunciation=efg&item=abc", AppScheme];
    NSAssert([url isKindOfClass:[NSURL class]], @"The slang detail route url is not an instance of NSURL");
    NSAssert([[url absoluteString] isEqualToString:correct1] || [[url absoluteString] isEqualToString:correct2], @"The slang route url is not right");
}

@end
