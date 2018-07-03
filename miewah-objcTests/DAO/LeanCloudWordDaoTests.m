//
//  LeanCloudWordDaoTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LeanCloudWordDAO.h"

@interface LeanCloudWordDaoTests : XCTestCase

@property (nonatomic, strong) LeanCloudWordDAO *wordDao;
@property (nonatomic, copy) NSString *objectId;

@end

@implementation LeanCloudWordDaoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLeanCloudGetCharacterListWithResults {
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Word 列表，返回结果包含若干个元素"];
    [self.wordDao getListAtPage:0 success:^(NSArray *results) {
        [expectation fulfill];
        XCTAssertTrue([results isKindOfClass:[NSArray class]]);
        XCTAssertTrue(results.count > 0);
        NSDictionary *object = [results firstObject];
        self.objectId = object[@"objectId"];
    } error:^(NSError *error) {
        [expectation fulfill];
        XCTFail(@"请求失败");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testLeanCloudGetCharacterListWithoutResults {
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Word 列表，返回结果不包含元素"];
    [self.wordDao getListAtPage:10000 success:^(NSArray *results) {
        [expectation fulfill];
        XCTAssertTrue([results isKindOfClass:[NSArray class]]);
        XCTAssertTrue(results.count == 0);
    } error:^(NSError *error) {
        [expectation fulfill];
        XCTFail(@"请求失败");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testLeanCloudGetCharacterDetailWithResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Word 详情，使用存在的 ID, 返回结果包含内容"];
    static NSString *identifier = @"5b39e5839f5454003b623418";
    [self.wordDao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
        [expectation fulfill];
        XCTAssertTrue([result isKindOfClass:[NSDictionary class]]);
        XCTAssertNotNil([result valueForKey:@"item"]);
    } error:^(NSError *error) {
        [expectation fulfill];
        XCTFail(@"请求失败");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testLeanCloudGetCharacterDetailWithoutResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Word 详情，使用不存在的 ID, 返回结果不包含内容"];
    static NSString *identifier = @"1";
    [self.wordDao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
        [expectation fulfill];
        XCTAssertTrue([result isKindOfClass:[NSDictionary class]]);
        XCTAssertNil([result valueForKey:@"item"]);
    } error:^(NSError *error) {
        [expectation fulfill];
        XCTFail(@"请求失败");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (LeanCloudWordDAO *)wordDao {
    if (_wordDao == nil) {
        _wordDao = [[LeanCloudWordDAO alloc] init];
    }
    return _wordDao;
}


@end
