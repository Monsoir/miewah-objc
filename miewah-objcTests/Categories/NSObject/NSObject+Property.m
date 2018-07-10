//
//  NSObject+Property.m
//  miewah-objcTests
//
//  Created by Christopher on 2018/7/10.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+Property.h"

@interface A: NSObject
@property (nonatomic, copy) NSString *a1;
@property (nonatomic, copy) NSString *a2;
@end
@implementation A
@end

@interface B: A
@property (nonatomic, copy) NSString *b1;
@property (nonatomic, copy) NSString *b2;
@end
@implementation B
@end

@interface C: B
@property (nonatomic, copy) NSString *c1;
@property (nonatomic, copy) NSString *c2;
@end
@implementation C
@end

@interface D: B
@property (nonatomic, copy) NSString *d1;
@property (nonatomic, copy) NSString *d2;
@end
@implementation D
@end

@interface NSObject_Property : XCTestCase

@end

@implementation NSObject_Property

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetPropertiesFromNil {
    NSSet *properties = [A propertiesListInheritedFromClass:nil];
    
    NSArray *shouldContains = @[@"a1", @"a2"];
    for (NSString *property in shouldContains) {
        NSAssert([properties containsObject:property], @"should contains %@", property);
    }
    
    NSArray *shouldNotContains = @[@"b1", @"b2", @"c1", @"c2",  @"d1", @"d2"];
    for (NSString *property in shouldNotContains) {
        NSAssert(![properties containsObject:property], @"should not contains %@", property);
    }
    
}

- (void)testGetPropertiesFromSelf {
    NSSet *properties = [B propertiesListInheritedFromClass:[B class]];

    NSArray *shouldContains = @[@"b1", @"b2"];
    for (NSString *property in shouldContains) {
        NSAssert([properties containsObject:property], @"should contains %@", property);
    }

    NSArray *shouldNotContains = @[@"a1", @"a2", @"c1", @"c2", @"d1", @"d2"];
    for (NSString *property in shouldNotContains) {
        NSAssert(![properties containsObject:property], @"should not contains %@", property);
    }
}

- (void)testGetPropertiesFromParent {
    NSSet *properties = [C propertiesListInheritedFromClass:[B class]];

    NSArray *shouldContains = @[@"c1", @"c2", @"b1", @"b2"];
    for (NSString *property in shouldContains) {
        NSAssert([properties containsObject:property], @"should contains %@", property);
    }

    NSArray *shouldNotContains = @[@"a1", @"a2", @"d1", @"d2"];
    for (NSString *property in shouldNotContains) {
        NSAssert(![properties containsObject:property], @"should not contains %@", property);
    }
}

- (void)testGetPropertiesFromGrandParent {
    NSSet *properties = [C propertiesListInheritedFromClass:[A class]];

    NSArray *shouldContains = @[@"a1", @"a2", @"b1", @"b2", @"c1", @"c2"];
    for (NSString *property in shouldContains) {
        NSAssert([properties containsObject:property], @"should contains %@", property);
    }

    NSArray *shouldNotContains = @[@"d1", @"d2"];
    for (NSString *property in shouldNotContains) {
        NSAssert(![properties containsObject:property], @"should not contains %@", property);
    }
}

@end
