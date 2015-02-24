//
//  provincesCoreData.m
//  NextJob
//
//  Created by Kyle Ju on 2015-02-22.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "provincesCoreData.h"
#import "FetchHelper.h"
#import "HourlyWageAndEmployerNumFetchHelp.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Provinces.h"

@implementation provincesCoreData


+ (void) createProvincesEntity: (NSString*) industry{
    ///industry is a integer GEO 2 - 11
    NSArray *provinces = @[@"Newfoundland and Labrador", @"Prince Edward Island", @"Nova Scotia", @"New Brunswick", @"Quebec", @"Ontario", @"Manitoba", @"Saskatchewan", @"Alberta", @"British Columbia"];
    
    NSArray *abbreviations = @[@"NL", @"PE", @"NS", @"NB", @"QC", @"ON", @"MB", @"SK", @"AB", @"BC"];
    
    NSMutableArray *scoreForVacancy = [FetchHelper jobShortageFetchHelper:industry];

    NSMutableArray *scoreForWage = [HourlyWageAndEmployerNumFetchHelp hourlyWageFetchHelper:industry];

    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];


    for (int i = 0; i < provinces.count; i ++){
    Provinces *newProvince = [NSEntityDescription insertNewObjectForEntityForName:@"Provinces" inManagedObjectContext:context];
        newProvince.provinceName = provinces[i];
        newProvince.abbreviation = abbreviations[i];
        newProvince.vacancyScore = [scoreForVacancy[i] intValue];
        newProvince.industry = industry;
        //newProvince.wageRateScore = [scoreForWage[i] intValue];
    }
    
    NSError *error = nil;
    if (! [context save: &error]){
        NSLog(@"%@", error);
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Provinces"];
    request.predicate = [NSPredicate predicateWithFormat:@"industry == %@", industry];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"vacancyScore" ascending:YES]];
    NSMutableArray *returnProvinces = [NSMutableArray arrayWithArray:[context executeFetchRequest:request error: &error]];
    
    for (int i = 0; i< returnProvinces.count; i++){
        Provinces *eachProvince = returnProvinces[i];
        eachProvince.vacancyRankings = i + 1;
    }
    
    if (! [context save: &error]){
        NSLog(@"%@", error);
    }

//    NSFetchRequest *newRequest = [NSFetchRequest fetchRequestWithEntityName:@"Provinces"];
//    newRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"wageRateScore" ascending:YES]];
//    NSMutableArray *returnProvinces2 = [NSMutableArray arrayWithArray:[context executeFetchRequest:newRequest error: &error]];
//    
//    for (int i = 0; i< returnProvinces2.count; i++){
//        Provinces *eachProvince = returnProvinces2[i];
//        eachProvince.wageRankings = i + 1;
//        eachProvince.sumRankings = eachProvince.vacancyRankings + eachProvince.wageRankings;
//    }
//    
//    if (! [context save: &error]){
//        NSLog(@"%@", error);
//    }
    
}

+ (NSMutableArray*)vacancyFetchProvinces: (NSString*) industry{
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Provinces"];
    request.predicate = [NSPredicate predicateWithFormat:@"industry == %@", industry];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"vacancyScore" ascending:YES]];
    NSError *error = nil;
    NSMutableArray *returnProvinces = [NSMutableArray arrayWithArray:[context executeFetchRequest:request error: &error]];
    
    return returnProvinces;
}



@end
