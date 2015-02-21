//
//  Entity.h
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * ageGroup;
@property (nonatomic, retain) NSString * geography;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * typeOfWork;
@property (nonatomic, retain) NSString * wageRates;
@property (nonatomic, retain) NSString * obsValue;
@property (nonatomic, retain) NSString * timePeriod;

@end
