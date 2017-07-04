//
//  HLNetTool.m
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLNetTool.h"

@implementation HLNetTool

//超时时间
static int const DEFAULT_REQUEST_TIME_OUT = 20;
+(AFHTTPSessionManager *)shareTools {
    static HLNetTool *sharedHttpSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHttpSession = [[HLNetTool alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        sharedHttpSession.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
        sharedHttpSession.responseSerializer = [AFJSONResponseSerializer serializer];
        sharedHttpSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"multipart/form-data",@"text/plain",nil];
        //开始监听网络状态
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];

    });
    
    return sharedHttpSession;
    
}

+(void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    
    AFHTTPSessionManager *manager = [self shareTools];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error = %@",error);
        }
        failure(error);
    }];
    
}
@end
