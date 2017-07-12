//
//  ClearCacheTool.h
//  StuManagement
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearCacheTool : NSObject

/**
 单例

 @return ClearCache
 */
+ (instancetype)shareClearCacheTools;

/**
 获取缓存大小

 @return 缓存大小
 */
- (CGFloat)getCacheTotalSize;


/**
 清理缓存
 */
- (void)clearCache;

@end
