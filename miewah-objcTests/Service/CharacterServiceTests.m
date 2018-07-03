//
//  CharacterServiceTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CharacterService.h"
#import "MiewahCharacter.h"

@interface CharacterServiceTests : XCTestCase

@property (nonatomic, strong) CharacterService *service;

@end

@implementation CharacterServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCharacterList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取一个 Character 列表"];
    static NSInteger pageIndex = 0;
    [self.service getListAtPageIndex:pageIndex completion:^(NSArray<MiewahAsset *> *list, NSError *error) {
        [expectation fulfill];
        XCTAssertNil(error, @"请求出错");
        XCTAssertNotNil(list, @"列表为 nil");
        XCTAssertTrue([list isKindOfClass:[NSArray class]], @"列表类型错误");
        XCTAssertTrue(list.count > 0, @"列表为空");
        
        id item = [list firstObject];
        XCTAssertTrue([item isKindOfClass:[MiewahCharacter class]], @"列表元素类型错误");
        XCTAssertNotNil(((MiewahCharacter *)item).objectId, @"元素缺少了 id");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testGetCharacterDetail {
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取一个 Character 详情"];
    static NSString *identifier = @"5b39d827756571003a6a76d5";
    [self.service getDetailOfIdentifier:identifier completion:^(MiewahAsset *asset, NSError *error) {
        [expectation fulfill];
        XCTAssertNil(error, @"请求出错");
        XCTAssertNotNil(asset, @"Character 转换出错");
        XCTAssertTrue([asset isKindOfClass:[MiewahCharacter class]], @"Character 类型错误");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (CharacterService *)service {
    if (_service == nil) {
        _service = [[CharacterService alloc] init];
    }
    return _service;
}

@end
