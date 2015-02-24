//
//  JobVacancy.h
//  Pods
//
//  Created by KP on 2/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JobVacancy : NSManagedObject

@property (nonatomic) int64_t geoLocation;
@property (nonatomic, retain) NSString * industry;
@property (nonatomic) int64_t numberOfVacancy;
@property (nonatomic) int64_t statsType;
@property (nonatomic) int64_t statesYear;

@end
