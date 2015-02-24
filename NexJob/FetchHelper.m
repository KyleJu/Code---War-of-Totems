//
//  FetchHelper.m
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "FetchHelper.h"
#import "AppDelegate.h"
#import "JobVacancy.h"


@implementation FetchHelper



+ (NSMutableArray*) jobShortageFetchHelper: (NSString*) industry{
    
    ///industry is a integer GEO 2 - 11
    NSArray *provinces = @[@"Newfoundland and Labrador", @"Prince Edward Island", @"Nova Scotia", @"New Brunswick", @"Quebec", @"Ontario", @"Manitoba", @"Saskatchewan", @"Alberta", @"British Columbia"];
    
    NSMutableArray *allStates = [[NSMutableArray alloc] init];
    
    for (int i = 2; i <= provinces.count + 1; i++){
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"JobVacancy"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(geoLocation == %i) AND (industry == %@)", i, industry];
        id delegateContext = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegateContext managedObjectContext];
        NSError *error = nil;
        NSMutableArray *returnStates = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchRequest error: &error]];
        [allStates addObject:returnStates];
    }
    
    // return a list of score for each provinces
    NSMutableArray *aListOfScore =[[NSMutableArray alloc] init];
    for (NSMutableArray *eachArray in allStates){
            NSNumber *score = [self overalScoreBasedOnPro:eachArray];
            [aListOfScore addObject:score];
            NSLog(@" %@ %lu", score, (unsigned long)eachArray.count);

    }
    
    //have all the provinces, all the vacancy at allStates and sum of the score at aListOfScore;
    return aListOfScore;
    
}


+ (NSNumber*)overalScoreBasedOnPro:(NSMutableArray*)eachProvinceArray{
    
    int sum = 0;
    if (eachProvinceArray.count != 0 || !eachProvinceArray){
        for (JobVacancy *eachStates in eachProvinceArray){
            sum = sum + eachStates.numberOfVacancy;
        }
    }else{
        NSNumber *nilValueNum = [[NSNumber alloc] initWithInt:0];
        return nilValueNum;
    }
    float averageSum = sum/(eachProvinceArray.count);
    return [NSNumber numberWithFloat:averageSum];
}






@end
