//
//  StructOfRegion.h
//  CQDownloadZip
//
//  Created by pauchen on 14-12-18.
//  Copyright (c) 2014年 pauchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StructOfRegion : NSObject

- (BOOL)loadRegionData:(NSDictionary* )dicRegion;

@property (nonatomic, strong)NSString* regionName;
@property (nonatomic, strong)NSString* zipUrl;
@property (nonatomic, strong)NSString* homePage;
//...
@end
