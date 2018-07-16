//
//  NSDictionary+JoinStringTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+JoinString.h"

@interface NSDictionary_JoinStringTests : XCTestCase

@property (nonatomic, strong) NSDictionary *aDict;

@end

@implementation NSDictionary_JoinStringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _aDict = @{
               @"foo": @"1",
               @"bar": @"2",
               };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJoinBySeparatorWithoutSeparator {
    NSString *joined = [self.aDict joinBySeparator:nil];
    NSAssert([joined isEqualToString:@"foo=1bar=2"] || [joined isEqualToString:@"bar=2foo=1"], @"Join by separator failed");
}

- (void)testJoinBySeparatorWithSeparator {
    NSString *joined = [self.aDict joinBySeparator:@"---"];
    NSAssert([joined isEqualToString:@"foo=1---bar=2"] || [joined isEqualToString:@"bar=2---foo=1"], @"Join by separator failed");
}

- (void)testQueryParams {
    NSString *queryParams = [self.aDict queryParams];
    NSAssert([queryParams isEqualToString:@"foo=1&bar=2"] || [queryParams isEqualToString:@"bar=2&foo=1"], @"Query params failed");
}

@end
