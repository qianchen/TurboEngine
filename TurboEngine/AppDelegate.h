//
//  AppDelegate.h
//  TurboEngine
//
//  Created by pauchen on 14-12-31.
//  Copyright (c) 2014年 capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (copy) void (^backgroundURLSessionCompletionHandler)();

@end

