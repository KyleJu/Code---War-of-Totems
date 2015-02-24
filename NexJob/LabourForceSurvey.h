//
//  LabourForceSurvey.h
//  
//
//  Created by KP on 2/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LabourForceSurvey : NSManagedObject

@property (nonatomic) int16_t ageGroup;
@property (nonatomic) int16_t geography;
@property (nonatomic, retain) NSString * industry;
@property (nonatomic) float obsValue;
@property (nonatomic) int16_t sex;
@property (nonatomic) NSTimeInterval timePeriod;
@property (nonatomic) int16_t typeOfWork;
@property (nonatomic) int16_t wageRates;

@end
