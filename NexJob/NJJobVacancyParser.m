//
//  NJJobVacancyParser.m
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJJobVacancyParser.h"
#import "AppDelegate.h"

@implementation NJJobVacancyParser


+(void) loadXML{
    //initalize sourceXML
    TBXML *sourceXML = [[TBXML alloc] initWithXMLFile:@"NJDataSetB.xml" error:nil];
    
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    [self traverseXMLElement:rootElement];
}

+(void)traverseXMLElement:(TBXMLElement *)element {
    TBXMLElement *seriesElement = [TBXML childElementNamed:@"cansim:Series" parentElement:element];
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    
    do{
        if ([[TBXML elementName:seriesElement] isEqualToString:@"cansim:Series"]){
            NSString *geoLocation = [TBXML valueOfAttributeNamed:@"GEO" forElement:seriesElement];
            NSString *statesType = [TBXML valueOfAttributeNamed:@"STATS" forElement:seriesElement];
            NSString *industry = [TBXML valueOfAttributeNamed:@"NAICS" forElement:seriesElement];
            
            //12 14 15 for territory of canada
            NSInteger geoInNum = [geoLocation intValue];
            BOOL isTerritory  = ((geoInNum == 12) || (geoInNum == 14) || (geoInNum == 15));
            
            TBXMLElement *eachElement = [TBXML childElementNamed:@"cansim:Obs" parentElement:seriesElement];
            do{
                //create object here
                NSString *statesYear = [TBXML valueOfAttributeNamed:@"TIME_PERIOD" forElement:eachElement];
                NSString *vacancyValue = [TBXML valueOfAttributeNamed:@"OBS_VALUE" forElement:eachElement];
                
                // only include # of shortage
                NSInteger statesTypeInNum = [statesType intValue];
                BOOL notTypeOne = ((statesTypeInNum == 2)|| (statesTypeInNum == 3));
                
                if (!([vacancyValue isEqualToString:@"F"] || [vacancyValue isEqualToString:@"x"] || isTerritory || notTypeOne)){
                 JobVacancy *newVacancy = [NSEntityDescription insertNewObjectForEntityForName: @"JobVacancy" inManagedObjectContext:context];
                    
                    newVacancy.geoLocation = [geoLocation intValue];
                    
                    NSInteger industryInNum = [industry intValue];
                    if ((industryInNum == 4) || (industryInNum == 10)){
                        newVacancy.industry = [@4 stringValue];
                    }
                    else if(industryInNum == 17){
                        newVacancy.industry = [@5 stringValue];
                    }
                    else if(industryInNum == 21){
                        newVacancy.industry = [@6 stringValue];
                    }
                    else if(industryInNum == 34){
                        newVacancy.industry = [@7 stringValue];
                    }
                    else if(industryInNum == 178){
                        newVacancy.industry = [@9 stringValue];
                    }
                    else if (industryInNum == 215){
                        newVacancy.industry = [@10 stringValue];
                    }
                    else if((industryInNum == 267) || (industryInNum == 284)){
                        newVacancy.industry = [@11 stringValue];
                    }
                    else if (industryInNum == 295){
                        newVacancy.industry = [@12 stringValue];
                    }
                    else if(industryInNum == 321){
                        newVacancy.industry = [@14 stringValue];
                    }
                    else if (industryInNum == 331){
                        newVacancy.industry = [@15 stringValue];
                    }
                    else if (industryInNum == 253){
                        newVacancy.industry = [@16 stringValue];
                    }
                    else if (industryInNum == 367){
                        newVacancy.industry = [@17 stringValue];
                    }else if (industryInNum == 377){
                        newVacancy.industry = [@18 stringValue];
                    }
                    else if (industryInNum == 393){
                        newVacancy.industry = [@19 stringValue];
                    }
                    else newVacancy.industry = [@100000 stringValue];
                    
                    newVacancy.statsType = [statesType intValue];
                    newVacancy.statesYear = [statesYear intValue];
                    newVacancy.numberOfVacancy = [vacancyValue floatValue] * 1000.0f;
                }


            }while ((eachElement = eachElement->nextSibling));
        }

    }while ((seriesElement = seriesElement->nextSibling));

    NSError *error = nil;
    if (! [context save: &error]){
        NSLog(@"%@", error);
    }
}
@end
