//
//  MyTest.m
//  UITest
//
//  Created by maqj on 15/9/3.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MainOPTableViewController.h"

@interface MyTest : XCTestCase
{
    MainOPTableViewController *moptvc;

}

@end

@implementation MyTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    moptvc = [[MainOPTableViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    [moptvc.navigationController pushViewController:moptvc animated:YES];

}

- (void)mytest{
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
