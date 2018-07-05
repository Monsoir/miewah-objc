//
//  DatetimeHelperTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/5.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatetimeHelper.h"

@interface DatetimeHelperTests : XCTestCase

@end

@implementation DatetimeHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConvertISODate2NormalFormatDate {
    NSString *source = @"2015-06-29T01:39:35.931Z";
    NSString *result = [DatetimeHelper convertISODate2NormalFormatDate:source];
    XCTAssertNotNil(result);
}

@end
