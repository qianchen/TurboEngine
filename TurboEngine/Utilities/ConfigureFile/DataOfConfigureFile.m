//
//  DataOfConfigure.m
//  CQDownloadZip
//
//  Created by pauchen on 14-12-18.
//  Copyright (c) 2014年 pauchen. All rights reserved.
//

#import "DataOfConfigureFile.h"


@implementation DataOfConfigureFile

__strong static DataOfConfigureFile* singleton = nil;

+ (DataOfConfigureFile* )sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[super allocWithZone:nil] init];
    });
    
    return singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (BOOL)readConfigToMemory:(NSDictionary *)configFile{
    //initial center node
    id nodeObject = [configFile objectForKey:@"center"];
    if ([nodeObject isKindOfClass:[NSArray class]]) {
        self.center = [[NSMutableArray alloc] init];
        
        NSArray* nodeArray = (NSArray* )nodeObject;
        for (int i = 0; i < nodeArray.count; i++) {
            nodeObject = [nodeArray objectAtIndex:i];
            if([nodeObject isKindOfClass:[NSDictionary class]]){
                StructOfRegion* region = [[StructOfRegion alloc] init];
                if([region initial:nodeObject]){
                    [self.center addObject:region];
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
    //initial appconfig node
    nodeObject = [configFile objectForKey:@"appconfig"];
    if ([nodeObject isKindOfClass:[NSDictionary class]]) {
        self.supportRotation = [nodeObject objectForKey:@"supportRotation"];
        NSString* temp = [nodeObject objectForKey:@"refreshTime"];
        self.refreshTime = temp.integerValue;
    } else {
        return NO;
    }
    
    return YES;
}

@end
