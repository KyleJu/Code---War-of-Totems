//
//  NSDataSetAParser.m
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NSDataSetAParser.h"

@implementation NSDataSetAParser

+ (void)loadXML {
    TBXML *sourceXML = [[TBXML alloc] initWithXMLFile:@"NJDataSetA.xml" error:nil];
    
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    
    [self traverseXMLElement:rootElement];
}

+ (void)traverseXMLElement:(TBXMLElement *)element {
    TBXMLElement *seriesElement = [TBXML childElementNamed:@"cansim:Series" parentElement:element];
    
    do {
        
        if (element->firstChild)
            
            [self traverseXMLElement:element->firstChild];
        
    } while ((element = element->nextSibling));
}


@end
