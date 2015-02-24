//
//  provincesCoreData.h
//  NextJob
//
//  Created by Kyle Ju on 2015-02-22.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface provincesCoreData : NSObject

+ (void) createProvincesEntity: (NSString*) industry;
+ (NSMutableArray*)vacancyFetchProvinces: (NSString*) idustry;

@end
