//
//  DataOfConfigure.h
//  CQDownloadZip
//
//  Created by pauchen on 14-12-18.
//  Copyright (c) 2014年 pauchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StructOfRegion.h"

@interface DataOfConfigureFile : NSObject

- (BOOL)loadConfigDataFromFile:(NSDictionary* )dicConfigFile;

@property (nonatomic, strong)NSMutableDictionary* regions;
@property bool supportOrientation;
@property int  refreshTime;
//...

@end
