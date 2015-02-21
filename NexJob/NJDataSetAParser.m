//
//  NJDataSetAParser.m
//  NexJob
//
//  Created by Ann Kim on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJDataSetAParser.h"
#import "TBXML.h"

@implementation NJDataSetAParser

+ (void)loadXML {
    
    TBXML *sourceXML = [[TBXMLalloc] initWithXMLFile:@"movies.xml"error:nil];
    
    TBXMLElement *rootElement = sourceXML.rootXMLElement;[/syntax]
    
    [self traverseXMLElement:rootElement];
}

+ (void)traverseXMLElement:(TBXMLElement *)element {
    do {
        
        if (element->firstChild)
            
            [self traverseXML:element->firstChild];
        
    } while ((element = element->nextSibling));
}

@end
