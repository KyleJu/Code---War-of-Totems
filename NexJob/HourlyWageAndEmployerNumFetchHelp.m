//
//  HourlyWageAndEmployerNumFetchHelp.m
//  NextJob
//
//  Created by Kyle Ju on 2015-02-22.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "HourlyWageAndEmployerNumFetchHelp.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "LabourForceSurvey.h"



@implementation HourlyWageAndEmployerNumFetchHelp

+ (NSMutableArray*) hourlyWageFetchHelper:(NSString *) industry{
    
    ///industry is a integer GEO 2 - 11
    NSArray *provinces = @[@"Newfoundland and Labrador", @"Prince Edward Island", @"Nova Scotia", @"New Brunswick", @"Quebec", @"Ontario", @"Manitoba", @"Saskatchewan", @"Alberta", @"British Columbia"];
    
    NSMutableArray *allStates = [[NSMutableArray alloc] init];
    
    for (int i = 2; i <= provinces.count + 1; i++){
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LabourForceSurvey"];
        
        //doublecheck with anns' geography
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(geography == %i) AND (industry == %@)", i, industry];
        id delegateContext = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegateContext managedObjectContext];
        NSError *error = nil;
        NSMutableArray *returnStates = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchRequest error: &error]];
        [allStates addObject:returnStates];
    }
    
    // return a list of score for each provinces
    NSMutableArray *aListOfScore =[[NSMutableArray alloc] init];
    for (NSMutableArray *eachArray in allStates){
        NSNumber *score = [self overalWageScoreBasedOnPro:eachArray];
        [aListOfScore addObject:score];
        NSLog(@" %@ %lu", score, (unsigned long)eachArray.count);
        
    }
    
    return aListOfScore;
    
}

+ (NSNumber*)overalWageScoreBasedOnPro:(NSMutableArray*)eachProvinceArray{
    
    int sum = 0.0f;
    if (eachProvinceArray.count != 0 || !eachProvinceArray){
        for (LabourForceSurvey *eachStates in eachProvinceArray){
            sum = sum + eachStates.obsValue;
        }
    }else{
        NSNumber *nilValueNum = [[NSNumber alloc] initWithFloat:0];
        return nilValueNum;
    }
    float averageSum = sum/(eachProvinceArray.count);
    return [NSNumber numberWithFloat:averageSum];
}

//
//
//
//
//
//+ (void) numOfEmployeesFetchHelper:(NSInteger) industry{
//    
//    ///industry is a integer GEO 2 - 11
//    NSArray *provinces = @[@"Newfoundland and Labrador", @"Prince Edward Island", @"Nova Scotia", @"New Brunswick", @"Quebec", @"Ontario", @"Manitoba", @"Saskatchewan", @"Alberta", @"British Columbia"];
//    
//    NSMutableArray *allStates = [[NSMutableArray alloc] init];
//    
//    for (int i = 2; i <= provinces.count + 1; i++){
//        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"labourForceSurvey"];
//        
//        //doublecheck with anns' geography
//        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(geography == %i) AND (industry == %i) AND (wageRates == 1)", i, industry];
//        id delegateContext = [[UIApplication sharedApplication] delegate];
//        NSManagedObjectContext *context = [delegateContext managedObjectContext];
//        NSError *error = nil;
//        NSMutableArray *returnStates = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchRequest error: &error]];
//        [allStates addObject:returnStates];
//    }
//    
//    // return a list of score for each provinces
//    NSMutableArray *aListOfScore =[[NSMutableArray alloc] init];
//    for (NSMutableArray *eachArray in allStates){
//        NSNumber *score = [self overalEmployeesScoreBasedOnPro:eachArray];
//        [aListOfScore addObject:score];
//        NSLog(@" %@ %lu", score, (unsigned long)eachArray.count);
//        
//    }
//    
//}
//
//+ (NSNumber*)overalEmployeesScoreBasedOnPro:(NSMutableArray*)eachProvinceArray{
//    
//    int sum = 0.0f;
//    if (eachProvinceArray.count != 0 || !eachProvinceArray){
//        for (LabourForceSurvey *eachStates in eachProvinceArray){
//            sum = sum + eachStates.obsValue * 1000.0f;
//        }
//    }else{
//        NSNumber *nilValueNum = [[NSNumber alloc] initWithFloat:0];
//        return nilValueNum;
//    }
//    float averageSum = sum/(eachProvinceArray.count);
//    return [NSNumber numberWithFloat:averageSum];
//}
@end
