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
            
    
            TBXMLElement *eachElement = [TBXML childElementNamed:@"cansim:Obs" parentElement:seriesElement];
            do{
                //create object here
                NSString *statesYear = [TBXML valueOfAttributeNamed:@"TIME_PERIOD" forElement:eachElement];
                NSString *vacancyValue = [TBXML valueOfAttributeNamed:@"OBS_VALUE" forElement:eachElement];
                if (!([vacancyValue isEqualToString:@"F"] || [vacancyValue isEqualToString:@"x"])){
                 JobVacancy *newVacancy = [NSEntityDescription insertNewObjectForEntityForName: @"JobVacancy" inManagedObjectContext:context];
                    
                    newVacancy.geoLocation = geoLocation;
                    newVacancy.industry = industry;
                    newVacancy.statsType = [statesType intValue];
                    newVacancy.statesYear = [statesYear intValue];
                    NSLog(@"The vacancy is %@ %@ %@ %@ %@", geoLocation, industry, statesType, statesYear, vacancyValue);
                    switch ([statesType intValue] - 1) {
                        case 0:{
                            newVacancy.numberOfVacancy = [vacancyValue intValue];
                            newVacancy.labourDemand = 0.0f;
                            newVacancy.vacancyRate = 0.0f;
                            break;
                        }
                        case 1:{
                            newVacancy.numberOfVacancy = 0.0f;
                            newVacancy.labourDemand = [vacancyValue intValue];
                            newVacancy.vacancyRate = 0.0f;
                            break;
                        }
                        case 2:{
                            newVacancy.numberOfVacancy = 0.0f;
                            newVacancy.labourDemand = 0.0f;
                            newVacancy.vacancyRate = [vacancyValue intValue];
                            break;
                        }
                            
                        default:
                            break;
                    }
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
