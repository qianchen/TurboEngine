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
    self.regionID = [dicRegion objectForKey:@"regionId"];
    self.regionName = [dicRegion objectForKey:@"regionName"];
    self.homePage = [dicRegion objectForKey:@"homePage"];
    
    id webResource = [dicRegion objectForKey:@"webResource"];
    if ([webResource isKindOfClass:[NSArray class]]) {
        self.webResource = webResource;
    } else {
        return NO;
    }
    return YES;
}

@end
