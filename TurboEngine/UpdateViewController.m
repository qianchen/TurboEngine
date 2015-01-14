//
//  UpdateViewController.m
//  TurboEngine
//
//  Created by pauchen on 15-1-14.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import "UpdateViewController.h"
#import "WebResourceDownloadManger.h"

@interface UpdateViewController()

@property (strong, nonatomic) WebResourceDownloadManger* downloadManger;

@property (strong, nonatomic) UIProgressView* downloadProgress;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.downloadProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.downloadProgress.center = self.view.center;
    self.downloadProgress.progress = 0.5f;
    
    [self.view addSubview:self.downloadProgress];
    //[self updateApplication];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WebResourceDownloadManger *)downloadManger{
    if (_downloadManger == nil) {
        _downloadManger = [[WebResourceDownloadManger alloc] init];
        
        __weak typeof(self) weakSelf = self;
        _downloadManger.progressHandle = ^(double progress){
            weakSelf.downloadProgress.progress = progress * 0.6;
        };
        _downloadManger.completionHandle = ^(){
            weakSelf.downloadProgress.progress = 0.6;
        };
        _downloadManger.failureHandle = ^(NSError* error){
            NSLog(@"Error: %@", error);
        };
    }
    
    return _downloadManger;
}

- (void)updateApplication{
    if (true) {//judge hash code
        BOOL isUpdate = true;//function to judge wifi and alert user whether to update
        if (isUpdate) {
            [self.downloadManger startDownloadAllPackages];
        } else {
            //is it ok to enter homePage without update ?
        }
    } else {
        //enter homePage directly
    }
}

@end
