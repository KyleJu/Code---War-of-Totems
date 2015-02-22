//
//  NJLabourForceSurveyParser.m
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJLabourForceSurveyParser.h"

@implementation NJLabourForceSurveyParser : NSObject 

+ (void)loadXML {
    TBXML *sourceXML = [[TBXML alloc] initWithXMLFile:@"NJDataSetA.xml" error:nil];
    
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    
    [self traverseXMLElement:rootElement];
}

+ (void)traverseXMLElement:(TBXMLElement *)element {
    TBXMLElement *seriesElement = [TBXML childElementNamed:@"cansim:Series" parentElement:element];
    
    do {
        
        if ( [[TBXML elementName:seriesElement] isEqualToString:@"cansim:Series"] ) {
            
            NSString *ageGroup = [TBXML valueOfAttributeNamed:@"AGEGROUP" forElement:seriesElement];
            NSString *sex = [TBXML valueOfAttributeNamed:@"SEX" forElement:seriesElement];
            NSString *wageRates = [TBXML valueOfAttributeNamed:@"WAGERATES" forElement:seriesElement];
            NSString *industry = [TBXML valueOfAttributeNamed:@"INDUSTRY" forElement:seriesElement];
            NSString *typeOfWork = [TBXML valueOfAttributeNamed:@"TYPEOFWORK" forElement:seriesElement];
            NSString *geography = [TBXML valueOfAttributeNamed:@"GEOGRAPHY" forElement:seriesElement];
            
            TBXMLElement *obsElement = [TBXML childElementNamed:@"cansim:Obs" parentElement:seriesElement];
            
            do {
                NSString *obsValueYear = [TBXML valueOfAttributeNamed:@"OBS_VALUE" forElement:seriesElement];
                NSString *timePeriodValue = [TBXML valueOfAttributeNamed:@"TIME_PERIOD" forElement:seriesElement];
                
            } while (obsElement == obsElement->nextSibling);
        }
        
    } while (seriesElement == seriesElement->nextSibling);
}

@end
