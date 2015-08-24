//
//  Employee.h
//  UITest
//
//  Created by maqj on 15/7/14.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSManagedObject *manager;

@end
