//
//  NJLabourForceSurveyParser.m
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJLabourForceSurveyParser.h"
#import "AppDelegate.h"
#import "LabourForceSurvey.h"

@implementation NJLabourForceSurveyParser

+ (void)loadXML {
    TBXML *sourceXML = [[TBXML alloc] initWithXMLFile:@"LabourForceSurvey.xml" error:nil];
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    [self traverseXMLElement:rootElement];
}

+ (void)traverseXMLElement:(TBXMLElement *)element {
    TBXMLElement *seriesElement = [TBXML childElementNamed:@"cansim:Series" parentElement:element];
    
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    
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
                
                NSString *obsValue = [TBXML valueOfAttributeNamed:@"OBS_VALUE" forElement:obsElement];
                NSString *timePeriod = [TBXML valueOfAttributeNamed:@"TIME_PERIOD" forElement:obsElement];
                
                int ageGroupInt = [ageGroup intValue];
                int sexInt = [sex intValue];
                int wageRatesInt = [wageRates intValue];
                int typeOfWorkInt = [typeOfWork intValue];
                int geographyInt = [geography intValue];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM"];
                
                NSDate *timePeriodDate = [dateFormatter dateFromString:timePeriod];
                NSTimeInterval timePeriodDateTimeInterval = [timePeriodDate timeIntervalSince1970];
//                NSLog(@"%f", timePeriodDateTimeInterval);
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                BOOL isDecimal = [obsValue isEqualToString:@"x"];
                if ( !((typeOfWorkInt == 2)||(typeOfWorkInt == 3) || (wageRatesInt == 1)|| (wageRatesInt == 3)|| (wageRatesInt == 4)|| (wageRatesInt == 5)||(sexInt == 2) || (sexInt == 3)||(ageGroupInt == 1)||(ageGroupInt==3)||(ageGroupInt == 4) || isDecimal)) {                    
                    float obsValueFloat = [obsValue floatValue];
                
                    LabourForceSurvey *labourForceSurvey = [NSEntityDescription insertNewObjectForEntityForName:@"LabourForceSurvey" inManagedObjectContext:context];
                    NSLog(@"WTF");
                    labourForceSurvey.ageGroup = ageGroupInt;
                    labourForceSurvey.sex = sexInt;
                    labourForceSurvey.wageRates = wageRatesInt;
                    labourForceSurvey.industry = industry;
                    labourForceSurvey.typeOfWork = typeOfWorkInt;
                    labourForceSurvey.geography = geographyInt;
                    labourForceSurvey.obsValue = obsValueFloat;
                    labourForceSurvey.timePeriod = timePeriodDateTimeInterval;
                }
                
            } while (( obsElement = obsElement->nextSibling ));
        }
        
    } while (( seriesElement = seriesElement->nextSibling ));
    
    NSError *error = nil;
    if (! [context save: &error]){
        NSLog(@"%@", error);
    }
    
    NSLog(@"finished Loading");
}

@end
