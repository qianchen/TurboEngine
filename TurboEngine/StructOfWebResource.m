//
//  StructOfWebResource.m
//  TurboEngine
//
//  Created by pauchen on 15-1-13.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import "StructOfWebResource.h"

@implementation StructOfWebResource

- (BOOL)initial:(NSDictionary *)dicRegion{
    self.zipUrl = [dicRegion objectForKey:@"zipUrl"];
    
    return true;
}
@end
