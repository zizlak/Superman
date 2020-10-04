//
//  FyberProjectTests.m
//  FyberProjectTests
//
//  Created by Aleksandr Kurdiukov on 02.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface FyberProjectTests : XCTestCase
@property ViewController *vcToTest;

@end

@implementation FyberProjectTests

- (void)setUp {
    [super setUp];
    _vcToTest = [[ViewController alloc] init];

}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    
   // _vcToTest.buttin
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
