//
//  NJJobVacancyParser.m
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJJobVacancyParser.h"

@implementation NJJobVacancyParser


+(void) loadXML{
    //initalize sourceXML
    TBXML *sourceXML = [[TBXML alloc] initWithXMLFile:@"NJDataSetB.xml" error:nil];
    
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    [self traverseXMLElement:rootElement];
}

+(void)traverseXMLElement:(TBXMLElement *)element {
    TBXMLElement *seriesElement = [TBXML childElementNamed:@"cansim:Series" parentElement:element];
    do{
        if ([[TBXML elementName:seriesElement] isEqualToString:@"cansim:Series"]){
            NSString *geoLocation = [TBXML valueOfAttributeNamed:@"GEO" forElement:seriesElement];
            NSString *industry = [TBXML valueOfAttributeNamed:@"STATS" forElement:seriesElement];
            NSString *jobType = [TBXML valueOfAttributeNamed:@"NAICS" forElement:seriesElement];
            
    
            TBXMLElement *eachElement = [TBXML childElementNamed:@"cansim:Obs" parentElement:seriesElement];
            do{
                //create object here
                NSString *statesYear = [TBXML valueOfAttributeNamed:@"TIME_PERIOD" forElement:eachElement];
                NSString *vacancyValue = [TBXML valueOfAttributeNamed:@"OBS_VALUE" forElement:eachElement];


            }while ((eachElement = eachElement->nextSibling));
            
            
            
        }

    }while ((seriesElement = seriesElement->nextSibling));


}
@end
