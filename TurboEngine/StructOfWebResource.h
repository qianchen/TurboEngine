//
//  StructOfWebResource.h
//  TurboEngine
//
//  Created by pauchen on 15-1-13.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StructOfWebResource : NSObject

@property (nonatomic, strong)NSString* zipUrl;
@property (nonatomic, strong)NSString* zipSize;

- (BOOL)initial:(NSDictionary* )dicWebResource;
@end
