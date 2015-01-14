//
//  ViewController.m
//  TurboEngine
//
//  Created by pauchen on 14-12-31.
//  Copyright (c) 2014年 capgemini. All rights reserved.
//

#import "LoadingViewController.h"
#import "DataOfConfigureFile.h"
#import "UpdateViewController.h"

@interface LoadingViewController ()


@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //add a background image.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString* configPath = @"http://127.0.0.1:7777/config.txt";
    [self downloadConfigFile:configPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadConfigFile:(NSString* )configPath{
    __block BOOL isErrorHappen = false;
    
    dispatch_queue_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(downloadQueue, ^{
        NSURL* configUrl = [NSURL URLWithString:configPath];
        NSURLRequest* request = [NSURLRequest requestWithURL:configUrl];
        NSError* downloadError = nil;
        NSData* configData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&downloadError];
        
        if (configData != nil && downloadError == nil) {
            if(![self parseConfigToMemory:configData]){
                NSLog(@"fail to store the configure data to memory!");
                isErrorHappen = true;
            }
            
            if(![self writeConfigToFile:configData]){
                NSLog(@"fail to store the local configure file!");
                isErrorHappen = true;
            }
            
            if (!isErrorHappen) {
                UpdateViewController* updateView = [[UpdateViewController alloc] init];
                updateView.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:updateView animated:YES completion:nil];
            }
        } else {
            NSLog(@"fail to get the configure data!");
            isErrorHappen = true;
        }
        
        dispatch_barrier_sync(downloadQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isErrorHappen) {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            });
        });
    });
    
}

- (BOOL)parseConfigToMemory:(NSData* )configData{
    NSError* parseError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingAllowFragments error:&parseError];
    
    if (jsonObject != nil && parseError == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dicConfig = (NSDictionary* )jsonObject;
            DataOfConfigureFile* configFile = [[DataOfConfigureFile alloc] init];
            if ([configFile readConfigToMemory:dicConfig]) {
                return true;
            } else {
                NSLog(@"fail to store config in memory");
            }
        }
    } else {
        NSLog(@"parse json error!");
    }

    return false;
}

- (BOOL)writeConfigToFile:(NSData* )configData{
    NSString* folderPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/config"];
    NSString* saveFilePath = [folderPath stringByAppendingString:@"/config.plist"];
    NSFileManager* fileManger = [NSFileManager defaultManager];
    if([fileManger createDirectoryAtPath:folderPath withIntermediateDirectories:true attributes:nil error:nil]){
        if ([fileManger createFileAtPath:saveFilePath contents:configData attributes:nil]) {
            return true;
        }
    }
    
    return false;
}
@end
