//
//  StructOfRegion.m
//  CQDownloadZip
//
//  Created by pauchen on 14-12-18.
//  Copyright (c) 2014年 pauchen. All rights reserved.
//

#import "StructOfRegion.h"

@implementation StructOfRegion

- (instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

- (BOOL)initial:(NSDictionary *)dicRegion{
    self.regionID = [dicRegion objectForKey:@"regionID"];
    self.regionName = [dicRegion objectForKey:@"regionName"];
    self.homePage = [dicRegion objectForKey:@"homePage"];
    
    id nodeObject = [dicRegion objectForKey:@"webResource"];
    if ([nodeObject isKindOfClass:[NSArray class]]) {
        self.webResource = [[NSMutableArray alloc] init];
        
        NSArray* nodeArray = (NSArray* )nodeObject;
        for (int i = 0; i < nodeArray.count; i++) {
            nodeObject = [nodeArray objectAtIndex:i];
            if([nodeObject isKindOfClass:[NSDictionary class]]){
                StructOfWebResource* webResource = [[StructOfWebResource alloc] init];
                if([webResource initial:nodeObject]){
                    [self.webResource addObject:nodeObject];
                }else{
                    return NO;
                }
                
            }else{
                return NO;
            }
        }

    } else {
        return NO;
    }
    return YES;
}

@end
