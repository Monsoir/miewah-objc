//
//  WordServiceTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WordService.h"
#import "MiewahWord.h"

@interface WordServiceTests : XCTestCase

@property (nonatomic, strong) WordService *service;

@end

@implementation WordServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCharacterList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取一个 Word 列表"];
    static NSInteger pageIndex = 0;
    [self.service getListAtPageIndex:pageIndex completion:^(NSArray<MiewahAsset *> *list, NSError *error) {
        [expectation fulfill];
        XCTAssertNil(error, @"请求出错");
        XCTAssertNotNil(list, @"列表为 nil");
        XCTAssertTrue([list isKindOfClass:[NSArray class]], @"列表类型错误");
        XCTAssertTrue(list.count > 0, @"列表为空");
        
        id item = [list firstObject];
        XCTAssertTrue([item isKindOfClass:[MiewahWord class]], @"列表元素类型错误");
        XCTAssertNotNil(((MiewahWord *)item).objectId, @"元素缺少了 id");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testGetCharacterDetail {
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取一个 Word 详情"];
    static NSString *identifier = @"5b39e5839f5454003b623418";
    [self.service getDetailOfIdentifier:identifier completion:^(MiewahAsset *asset, NSError *error) {
        [expectation fulfill];
        XCTAssertNil(error, @"请求出错");
        XCTAssertNotNil(asset, @"Word 转换出错");
        XCTAssertTrue([asset isKindOfClass:[MiewahWord class]], @"Word 类型错误");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (WordService *)service {
    if (_service == nil) {
        _service = [[WordService alloc] init];
    }
    return _service;
}

@end
