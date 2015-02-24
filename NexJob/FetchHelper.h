//
//  FetchHelper.h
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FetchHelper : NSObject

+ (NSMutableArray*) jobShortageFetchHelper: (NSString*) industry;
+ (NSNumber*)overalScoreBasedOnPro:(NSMutableArray*)eachProvinceArray;
@end
