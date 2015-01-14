//
//  webResourceDownloader.h
//  TurboEngine
//
//  Created by pauchen on 15-1-14.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebResourceDownloadManger : NSObject

- (void)startDownloadAllPackages;

@property (nonatomic, copy) void (^progressHandle)(double progress);
@property (nonatomic, copy) void (^completionHandle)();
@property (nonatomic, copy) void (^failureHandle)(NSError* error);
@end
