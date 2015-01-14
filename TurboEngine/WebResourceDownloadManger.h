//
//  webResourceDownloader.h
//  TurboEngine
//
//  Created by pauchen on 15-1-14.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebResourceDownloadDelegate <NSObject>


@end

@interface WebResourceDownloadManger : NSObject<NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (strong, nonatomic)NSMutableArray* webResources;

@end
