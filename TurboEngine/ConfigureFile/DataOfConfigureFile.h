//
//  DataOfConfigure.h
//  CQDownloadZip
//
//  Created by pauchen on 14-12-18.
//  Copyright (c) 2014年 pauchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StructOfRegion.h"
#import "StructOfAppconfig.h"

@interface DataOfConfigureFile : NSObject

+ (DataOfConfigureFile* )sharedInstance;
- (BOOL)readConfigToMemory:(NSDictionary* )configFile;

@property (nonatomic, strong)NSMutableArray* center;
@property (nonatomic, strong)StructOfAppconfig* appconfig;

@end
