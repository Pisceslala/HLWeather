//
//  ClearCacheTool.m
//  StuManagement
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "ClearCacheTool.h"
#import <SDImageCache.h>
//#define cachePath
@implementation ClearCacheTool

+ (instancetype)shareClearCacheTools {
    static ClearCacheTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ClearCacheTool alloc] init];
    });
    return tool;
}

-(CGFloat)getCacheTotalSize {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //创建文件管理者
    NSFileManager *fileManager=[NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[cachePath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

- (CGFloat)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

#pragma mark--清除缓存
-(void)clearCache{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            if ([fileName isEqualToString:@"com.pinterest.PINDiskCache.PINCacheShared"] ||
                [fileName isEqualToString:@"com.pinterest.PINDiskCache.PINCacheShared/CITYNAME"] ||
                [fileName isEqualToString:@"com.pinterest.PINDiskCache.PINCacheShared/PROVINCE"] ||
                [fileName isEqualToString:@"com.pinterest.PINDiskCache.PINCacheShared/PhotoCache"] ||
                [fileName isEqualToString:@"com.pinterest.PINDiskCache.PINCacheShared/newCount"] ||
                [fileName isEqualToString:@"com.pinterest.PINDiskCache.PINCacheShared/oldCount"]) {
                continue;
            }
            NSString *absolutePath=[cachePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
}


@end
