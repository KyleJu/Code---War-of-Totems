//
//  NJJobProjectionFetch.m
//  NexJob
//
//  Created by Ann Kim on 2015-02-22.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJJobProjectionFetch.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "JobProjection.h"

@implementation NJJobProjectionFetch

+ (NSMutableArray *)jobProjectionFetchHelper:(NSArray *)groupArray withIndustry:(NSArray *)industryArray {
    
    NSMutableArray *allGroupJobProjectionArray = [[NSMutableArray alloc] init];
    NSMutableArray *allIndustryJobProjectionArray = [[NSMutableArray alloc] init];
    
    for ( NSString *group in groupArray ) {
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"JobProjection"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"group == %@", group];
        
        id delegateContext = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegateContext managedObjectContext];
        NSError *error = nil;
        
        NSMutableArray *groupJobProjectionArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchRequest error:&error]];
        
        for ( JobProjection *jobProjection in groupJobProjectionArray ) {
            [allGroupJobProjectionArray addObject:jobProjection];
        }
    }
    
    for ( NSString *industry in industryArray ) {
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"JobProjection"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"industry == %@", industry];
        
        id delegateContext = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegateContext managedObjectContext];
        NSError *error = nil;
        
        NSMutableArray *industryJobProjectionArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchRequest error:&error]];
        
        for ( JobProjection *jobProjection in industryJobProjectionArray ) {
            [allIndustryJobProjectionArray addObject:jobProjection];
        }
    }
    
    NSMutableArray *jobProjectionArray = [NSMutableArray arrayWithArray:[allGroupJobProjectionArray arrayByAddingObjectsFromArray:allIndustryJobProjectionArray]];
//    NSLog(@"%@", jobProjectionArray);
    
//    for ( JobProjection *jobProjection in jobProjectionArray) {
//        NSLog(@"%d, %@, %@, %f", jobProjection.code, jobProjection.group, jobProjection.jobTitle, jobProjection.projectionAverage);
//    }
    
    return jobProjectionArray;
}

@end
