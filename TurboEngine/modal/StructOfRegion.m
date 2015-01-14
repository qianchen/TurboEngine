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

- (BOOL)loadRegionData:(NSDictionary* )dicRegion{
    if (nil == dicRegion) {
        return NO;
    }
    
    _zipUrl = [dicRegion objectForKey:@"zipurl"];
    _homePage = [dicRegion objectForKey:@"homepage"];
    
    return YES;
}
@end
