//
//  StructOfWebResource.m
//  TurboEngine
//
//  Created by pauchen on 15-1-13.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import "StructOfWebResource.h"

@implementation StructOfWebResource

- (BOOL)initial:(NSDictionary *)dicWebResource{
    self.zipUrl = [dicWebResource objectForKey:@"zipUrl"];
    self.zipSize = [dicWebResource objectForKey:@"zipSize"];
    
    return true;
}
@end
