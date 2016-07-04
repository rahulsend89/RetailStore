//
//  RetailStoreTests.m
//  RetailStoreTests
//
//  Created by Rahul Malik on 2/23/16.
//  Copyright © 2016 Rahul Malik. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductData.h"
@interface RetailStoreTests : XCTestCase

@end

@implementation RetailStoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testproductData {
    ProductData *productData = [ProductData sharedData];
    XCTAssert(productData.tampData.count,"count souuld be greater then 10");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
