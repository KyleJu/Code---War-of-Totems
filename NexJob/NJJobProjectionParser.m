//
//  NJJobProjectionParser.m
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJJobProjectionParser.h"
#import "AppDelegate.h"
#import "JobProjection.h"

@implementation NJJobProjectionParser

+ (void)loadXML {
    TBXML *sourceXML = [[TBXML alloc] initWithXMLFile:@"JobProjection.xml" error:nil];
    
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    
    [self traverseXMLElement:rootElement];
}

+ (void)traverseXMLElement:(TBXMLElement *)element {
    TBXMLElement *rowElement = [TBXML childElementNamed:@"ROW" parentElement:element];
    
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    
    do {
        
        if ( [[TBXML elementName:rowElement] isEqualToString:@"ROW"] ) {
            
            TBXMLElement *codeElement = [TBXML childElementNamed:@"CODE" parentElement:rowElement];
            NSString *code = [TBXML textForElement:codeElement];
            TBXMLElement *projection12Element = [TBXML childElementNamed:@"2012" parentElement:rowElement];
            NSString *projection12 = [TBXML textForElement:projection12Element];
            TBXMLElement *projection13Element = [TBXML childElementNamed:@"2013" parentElement:rowElement];
            NSString *projection13 = [TBXML textForElement:projection13Element];
            TBXMLElement *projection14Element = [TBXML childElementNamed:@"2014" parentElement:rowElement];
            NSString *projection14 = [TBXML textForElement:projection14Element];
            TBXMLElement *projection15Element = [TBXML childElementNamed:@"2015" parentElement:rowElement];
            NSString *projection15 = [TBXML textForElement:projection15Element];
            TBXMLElement *projection16Element = [TBXML childElementNamed:@"2016" parentElement:rowElement];
            NSString *projection16 = [TBXML textForElement:projection16Element];
            TBXMLElement *projection17Element = [TBXML childElementNamed:@"2017" parentElement:rowElement];
            NSString *projection17 = [TBXML textForElement:projection17Element];
            TBXMLElement *projection18Element = [TBXML childElementNamed:@"2018" parentElement:rowElement];
            NSString *projection18 = [TBXML textForElement:projection18Element];
            TBXMLElement *projection19Element = [TBXML childElementNamed:@"2019" parentElement:rowElement];
            NSString *projection19 = [TBXML textForElement:projection19Element];
            TBXMLElement *projection20Element = [TBXML childElementNamed:@"2020" parentElement:rowElement];
            NSString *projection20 = [TBXML textForElement:projection20Element];
            TBXMLElement *projection21Element = [TBXML childElementNamed:@"2021" parentElement:rowElement];
            NSString *projection21 = [TBXML textForElement:projection21Element];
            TBXMLElement *projection22Element = [TBXML childElementNamed:@"2022" parentElement:rowElement];
            NSString *projection22 = [TBXML textForElement:projection22Element];
            TBXMLElement *projectionAverageElement = [TBXML childElementNamed:@"AVERAGE" parentElement:rowElement];
            NSString *projectionAverage = [TBXML textForElement:projectionAverageElement];
            TBXMLElement *jobTitleElement = [TBXML childElementNamed:@"JOB_TITLE" parentElement:rowElement];
            NSString *jobTitle = [TBXML textForElement:jobTitleElement];
            TBXMLElement *groupElement = [TBXML childElementNamed:@"GROUP" parentElement:rowElement];
            NSString *group = [TBXML textForElement:groupElement];            TBXMLElement *industryElement = [TBXML childElementNamed:@"INDUSTRY" parentElement:rowElement];
            NSString *industry = [TBXML textForElement:industryElement];
            
//            NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@", code, projection12, projection13, projection14, projection15, projection16, projection17, projection18, projection19, projection20, projection21, projection22, projectionAverage, jobTitle, group, industry);
            
            code = [code stringByReplacingOccurrencesOfString:@"N" withString:@""];
            int codeInt = [code intValue];
//            NSLog(@"%d", codeInt);
            
            float projection12Float = [projection12 floatValue];
            float projection13Float = [projection13 floatValue];
            float projection14Float = [projection14 floatValue];
            float projection15Float = [projection15 floatValue];
            float projection16Float = [projection16 floatValue];
            float projection17Float = [projection17 floatValue];
            float projection18Float = [projection18 floatValue];
            float projection19Float = [projection19 floatValue];
            float projection20Float = [projection20 floatValue];
            float projection21Float = [projection21 floatValue];
            float projection22Float = [projection22 floatValue];
            float projectionAverageFloat = [projectionAverage floatValue];
            
            JobProjection *jobProjection = [NSEntityDescription insertNewObjectForEntityForName:@"JobProjection" inManagedObjectContext:context];
            jobProjection.code = codeInt;
            jobProjection.projection12 = projection12Float;
            jobProjection.projection13 = projection13Float;
            jobProjection.projection14 = projection14Float;
            jobProjection.projection15 = projection15Float;
            jobProjection.projection16 = projection16Float;
            jobProjection.projection17 = projection17Float;
            jobProjection.projection18 = projection18Float;
            jobProjection.projection19 = projection19Float;
            jobProjection.projection20 = projection20Float;
            jobProjection.projection21 = projection21Float;
            jobProjection.projection22 = projection22Float;
            jobProjection.projectionAverage = projectionAverageFloat;
            jobProjection.jobTitle = jobTitle;
            jobProjection.group = group;
            jobProjection.industry = industry;
        }
        
    } while (( rowElement = rowElement->nextSibling ));
    
    NSError *error = nil;
    if (! [context save: &error]){
        NSLog(@"%@", error);
    }
}

@end
