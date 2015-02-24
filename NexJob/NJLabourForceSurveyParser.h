//
//  NJLabourForceSurveyParser.h
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"

@interface NJLabourForceSurveyParser : UIViewController

+ (void)loadXML;
+ (void)traverseXMLElement:(TBXMLElement *)element;

@end
