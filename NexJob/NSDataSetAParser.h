//
//  NSDataSetAParser.h
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LabourForceSurvey.h"
#import "TBXML.h"

@interface NSDataSetAParser : NSObject

+ (void)loadXML;
+ (void)traverseXMLElement:(TBXMLElement *)element;

@end
