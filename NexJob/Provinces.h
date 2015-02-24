//
//  Provinces.h
//  NexJob
//
//  Created by Kyle Ju on 2015-02-22.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Provinces : NSManagedObject

@property (nonatomic, retain) NSString * abbreviation;
@property (nonatomic) int64_t employeeScore;
@property (nonatomic, retain) NSString * provinceName;
@property (nonatomic) int64_t sumRankings;
@property (nonatomic) int64_t vacancyRankings;
@property (nonatomic) int64_t vacancyScore;
@property (nonatomic) int64_t wageRankings;
@property (nonatomic) int64_t wageRateScore;
@property (nonatomic, retain) NSString * industry;

@end
