//
//  ViewController.m
//  down
//
//  Created by fairy on 15/12/8.
//  Copyright © 2015年 fairy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tap:(id)sender {

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       NSLog(@"data > %@", data);
                                                   }];
    [dataTask resume];
    //    [dataTask suspend];
    //    [dataTask cancel];
    
    NSURLSessionDownloadTask *downloadTask = [urlSession downloadTaskWithRequest:request
                                                               completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                   NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                                                                   NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
                                                                   NSURL *newFileLocation = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
                                                                   [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFileLocation error:nil];
                                                               }];
    [downloadTask resume];
    
    NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request
                                                                  fromData:nil
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             
                                                         }];
    [uploadTask resume];   }

-(void)post
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"url地址"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[@"version=1.0.0&os_version=7.1.2&os_type=iOS" dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSLog(@"获取到的数据>%@", [[NSString alloc] initWithData:data
                                                                                              encoding:NSUTF8StringEncoding]);
                                                }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
