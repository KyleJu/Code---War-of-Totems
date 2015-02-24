//
//  JobProjection.h
//  
//
//  Created by KP on 2/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JobProjection : NSManagedObject

@property (nonatomic) int16_t code;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSString * industry;
@property (nonatomic, retain) NSString * jobTitle;
@property (nonatomic) float projection12;
@property (nonatomic) float projection13;
@property (nonatomic) float projection14;
@property (nonatomic) float projection15;
@property (nonatomic) float projection16;
@property (nonatomic) float projection17;
@property (nonatomic) float projection18;
@property (nonatomic) float projection19;
@property (nonatomic) float projection20;
@property (nonatomic) float projection21;
@property (nonatomic) float projection22;
@property (nonatomic) float projectionAverage;

@end
