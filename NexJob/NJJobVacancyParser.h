//
//  NJJobVacancyParser.h
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "JobVacancy.h"
@interface NJJobVacancyParser : NSObject

+ (void)loadXML;
+ (void)traverseXMLElement:(TBXMLElement *)element;

@end
