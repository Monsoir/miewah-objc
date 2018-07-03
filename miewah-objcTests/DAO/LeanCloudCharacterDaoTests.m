//
//  LeanCloudCharacterDaoTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LeanCloudCharacterDAO.h"

@interface LeanCloudCharacterDaoTests : XCTestCase

@property (nonatomic, strong) LeanCloudCharacterDAO *characterDao;
@property (nonatomic, copy) NSString *objectId;

@end

@implementation LeanCloudCharacterDaoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLeanCloudGetCharacterListWithResults {
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Character 列表，返回结果包含若干个元素"];
    [self.characterDao getListAtPage:0 success:^(NSArray *results) {
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
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Character 列表，返回结果不包含元素"];
    [self.characterDao getListAtPage:10000 success:^(NSArray *results) {
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
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Character 详情，使用存在的 ID, 返回结果包含内容"];
    static NSString *identifier = @"5b39d827756571003a6a76d5";
    [self.characterDao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
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
    XCTestExpectation *expectation = [self expectationWithDescription:@"请求 Character 详情，使用不存在的 ID, 返回结果不包含内容"];
    static NSString *identifier = @"1";
    [self.characterDao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
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

- (LeanCloudCharacterDAO *)characterDao {
    if (_characterDao == nil) {
        _characterDao = [[LeanCloudCharacterDAO alloc] init];
    }
    return _characterDao;
}

@end
