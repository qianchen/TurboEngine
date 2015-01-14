//
//  webResourceDownloader.m
//  TurboEngine
//
//  Created by pauchen on 15-1-14.
//  Copyright (c) 2015年 capgemini. All rights reserved.
//

#import "WebResourceDownloadManger.h"
#import "DataOfConfigureFile.h"
#import "AppDelegate.h"

@interface WebResourceDownloadManger()<NSURLSessionDownloadDelegate, NSURLSessionDelegate>

@property (strong, nonatomic)dispatch_queue_t downloadQueue;
@property (strong, nonatomic)NSMutableArray* webResources;
@property long long currentLength;
@property long long totalSize;

@property (strong, nonatomic) NSURLSession* backgroundSession;
@property (strong, nonatomic) NSURLSessionTask* backgroundTask;
@end

@implementation WebResourceDownloadManger

- (instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    [self __init];
    return self;
}

- (void)__init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.webResources = [[NSMutableArray alloc] init];
        self.downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"backgroundSession"];
        self.backgroundSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    });
    
    self.totalSize = 0;
    self.currentLength = 0;
}

- (void)startDownloadAllPackages{
    [self getLocalWebResourcePath];
   
    for (NSString* zipUrl in self.webResources) {
        dispatch_async(self.downloadQueue, ^{
            [self startBackground:zipUrl];
        });
    }
}

- (void)getLocalWebResourcePath{
    DataOfConfigureFile* configFile = [DataOfConfigureFile sharedInstance];
    for (StructOfRegion* region in configFile.center) {
        if ([region.regionID  isEqual: @"1001"]) {

            for (StructOfWebResource* resource in region.webResource) {
                [self.webResources addObject:resource.zipUrl];
                self.totalSize += resource.zipSize.integerValue;
                
            }
        }
    }
}

- (void)startBackground:(NSString* )filePath{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    self.backgroundTask = [self.backgroundSession downloadTaskWithRequest:request];
    [self.backgroundTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate methods
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.currentLength += totalBytesWritten;
    double currentProgress = (double)self.currentLength / self.totalSize;
    //progress display
    if ([self progressHandle]) {
        self.progressHandle(currentProgress);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    if ([self completionHandle]) {
        self.completionHandle();
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLs[0];
    NSURL* destinationDirectory = [documentsDirectory URLByAppendingPathComponent:@"packages/"];
    
    [fileManager createDirectoryAtURL:destinationDirectory withIntermediateDirectories:true attributes:nil error:nil];
    
    NSString* fileName = downloadTask.originalRequest.URL.absoluteString.lastPathComponent;
    NSURL *destinationPath = [destinationDirectory URLByAppendingPathComponent:fileName];
    NSError *error;
    // Make sure we overwrite anything that's already there
    [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    if (!success)
    {
        NSLog(@"Couldn't copy the downloaded file");
    }
    self.backgroundTask = nil;
    // Get hold of the app delegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.backgroundURLSessionCompletionHandler) {
        // Need to copy the completion handler
        void (^handler)() = appDelegate.backgroundURLSessionCompletionHandler;
        appDelegate.backgroundURLSessionCompletionHandler = nil;
        handler();
    }
}

#pragma mark - NSURLSessionDelegate methods
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if ([self failureHandle]) {
        self.failureHandle(error);
    }
}
@end
