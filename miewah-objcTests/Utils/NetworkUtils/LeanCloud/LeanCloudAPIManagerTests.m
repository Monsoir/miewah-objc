//
//  LeanCloudAPIManagerTests.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LeanCloudAPIManager.h"
#import "LeanCloudAPIAddresses.h"

@interface LeanCloudAPIManagerTests : XCTestCase

@end

@implementation LeanCloudAPIManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCharacterListURL {
    static NSInteger pageIndex = 1;
    static NSInteger PageSize = 10;
    NSString *testingURL = [SharedLeanCloudAPIManager characterListURLWithPageIndex:pageIndex];
    NSString *destURL = [NSString stringWithFormat:@"%@%@?limit=%ld&&order=-updatedAt&&keys=item,pronunciation,meaning&&skip=%ld", LeanCloudBaseURL, LeanCloudCharacterListURL, PageSize, pageIndex];
    XCTAssertTrue([testingURL isEqualToString:destURL]);
}

- (void)testCharacterDetailURL {
    static NSString * identifier = @"afs3413dffe";
    NSString *testingURL = [SharedLeanCloudAPIManager characterDetailOfIdentifier:identifier];
    NSString *destURL = [NSString stringWithFormat:@"%@%@/%@", LeanCloudBaseURL, LeanCloudCharacterDetailURL, identifier];
    XCTAssertTrue([testingURL isEqualToString:destURL]);
}

- (void)testWordListURL {
    static NSInteger pageIndex = 1;
    static NSInteger PageSize = 10;
    NSString *testingURL = [SharedLeanCloudAPIManager wordListURLWithPageIndex:pageIndex];
    NSString *destURL = [NSString stringWithFormat:@"%@%@?limit=%ld&&order=-updatedAt&&keys=item,pronunciation,meaning&&skip=%ld", LeanCloudBaseURL, LeanCloudWordListURL, PageSize, pageIndex];
    XCTAssertTrue([testingURL isEqualToString:destURL]);
}

- (void)testWordDetailURL {
    static NSString * identifier = @"afs3413dffe";
    NSString *testingURL = [SharedLeanCloudAPIManager wordDetailOfIdentifier:identifier];
    NSString *destURL = [NSString stringWithFormat:@"%@%@/%@", LeanCloudBaseURL, LeanCloudWordDetailURL, identifier];
    XCTAssertTrue([testingURL isEqualToString:destURL]);
}

- (void)testSlangListURL {
    static NSInteger pageIndex = 1;
    static NSInteger PageSize = 10;
    NSString *testingURL = [SharedLeanCloudAPIManager slangListURLWithPageIndex:pageIndex];
    NSString *destURL = [NSString stringWithFormat:@"%@%@?limit=%ld&&order=-updatedAt&&keys=item,pronunciation,meaning&&skip=%ld", LeanCloudBaseURL, LeanCloudSlangListURL, PageSize, pageIndex];
    XCTAssertTrue([testingURL isEqualToString:destURL]);
}

- (void)testSlangDetailURL {
    static NSString * identifier = @"afs3413dffe";
    NSString *testingURL = [SharedLeanCloudAPIManager slangDetailOfIdentifier:identifier];
    NSString *destURL = [NSString stringWithFormat:@"%@%@/%@", LeanCloudBaseURL, LeanCloudSlangDetailURL, identifier];
    XCTAssertTrue([testingURL isEqualToString:destURL]);
}

@end
