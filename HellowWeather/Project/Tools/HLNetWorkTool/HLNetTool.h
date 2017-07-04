//
//  HLNetTool.h
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HLNetTool : AFHTTPSessionManager

/**
 单例

 @return HLNetTool
 */
+(AFHTTPSessionManager *_Nonnull)shareTools;

/**
 *  发送GET请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(nonnull NSString *)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(id _Nullable responseObject))success
    failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
