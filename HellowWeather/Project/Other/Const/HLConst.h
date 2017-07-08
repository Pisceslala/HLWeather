//
//  HLConst.h
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIKIT_EXTERN	        extern __attribute__((visibility ("default")))
@interface HLConst : NSObject

//baseURL
UIKIT_EXTERN NSString * const BASEURL;
//根据城市名查询天气
UIKIT_EXTERN NSString * const query;
//城市列表
UIKIT_EXTERN NSString * const citys;
//天气类型
UIKIT_EXTERN NSString * const type;
//APPKEY
UIKIT_EXTERN NSString * const appkey;

UIKIT_EXTERN NSString * const environmentQuery;

UIKIT_EXTERN NSString * const environmentCitys;

//图片Url
UIKIT_EXTERN NSString * const unsplashAppKey;

UIKIT_EXTERN NSString * const unsplashPhotoURL;

UIKIT_EXTERN NSString * const unsplashPhotoCallBackURL;

//图片缓存
UIKIT_EXTERN NSString * const PhotoCache;
@end
