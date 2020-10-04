//
//  FyberProjectUITests.m
//  FyberProjectUITests
//
//  Created by Aleksandr Kurdiukov on 02.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FyberProjectUITests : XCTestCase

@end

@implementation FyberProjectUITests

- (void)setUp {
    self.continueAfterFailure = NO;
    [[XCUIApplication alloc] init].launch;

}

- (void)tearDown {
}

- (void)testTapTextFields {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.textFields[@"AppID"] tap];
    [app.textFields[@"User ID"] tap];
    [app.buttons[@"Button"] tap];
}


- (void)testTextFieldAppID {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.textFields[@"AppID"] tap];
    [app.textFields[@"AppID"] typeText:@"2070"];
    
    XCUIElement *userIdTextField = app.textFields[@"User ID"];
    [userIdTextField tap];
    [userIdTextField tap];
}


- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[XCTOSSignpostMetric.applicationLaunchMetric] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
