//
//  DataOfConfigure.m
//  CQDownloadZip
//
//  Created by pauchen on 14-12-18.
//  Copyright (c) 2014年 pauchen. All rights reserved.
//

#import "DataOfConfigureFile.h"


@implementation DataOfConfigureFile

- (instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    if (nil == _regions) {
        _regions = [[NSMutableDictionary alloc] init];
    }
    _supportOrientation = true;
    _refreshTime = 10;
    
    return self;
}

- (BOOL)loadConfigDataFromFile:(NSDictionary* )dicConfigFile{
    if (nil == dicConfigFile) {
        return NO;
    }
    
    NSDictionary* centerNode = [dicConfigFile objectForKey:@"center"];
    
    for (int i = 0; i < [centerNode allKeys].count; i++) {
        
        NSString* regionName = [[centerNode allKeys] objectAtIndex:i];
        
        StructOfRegion* region = [[StructOfRegion alloc] init];
        region.regionName = regionName;
        NSDictionary* dicRegion = [centerNode objectForKey:regionName];
        [region loadRegionData:dicRegion];
        [_regions setValue:region forKey:regionName];
    }
    
    NSDictionary* dicAppConfig = [dicConfigFile objectForKey:@"appconfig"];
    _supportOrientation = [dicAppConfig objectForKey:@"supportrotation"];
    NSString* strRefreshTime = [dicAppConfig objectForKey:@"refreshtime"];
    _refreshTime = [strRefreshTime intValue];
    
    return YES;
}

@end
