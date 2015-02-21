//
//  JobVacancy.h
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JobVacancy : NSManagedObject

@property (nonatomic, retain) NSString * geoLocation;
@property (nonatomic, retain) NSString * industry;
@property (nonatomic) int64_t statsType;
@property (nonatomic) int64_t statesYear;
@property (nonatomic) float numberOfVacancy;
@property (nonatomic) float labourDemand;
@property (nonatomic) float vacancyRate;

@end
