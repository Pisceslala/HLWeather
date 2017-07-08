//
//  AlertControllerTool.h
//  Project
//
//  Created by Jason.Jun on 2017/2/24.
//  Copyright © 2017年 hongsi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 系统弹窗封装
@interface AlertControllerTool : NSObject


/**
 普通样式
 @param message 内容
 @param sureTitle 确定按钮的文字
 @param cancelTitle 取消按钮的文字
 @param confirmHandler 确认回调
 @param cancleHandler 取消回调
 */
+(void)alertMesasge:(NSString *)message
          sureTitle:(NSString *)sureTitle
        cancelTitle:(NSString *)cancelTitle
     confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
      cancleHandler:(void(^)(UIAlertAction *action))cancleHandler;


/**
 左普通 右销毁样式
 @param message 内容
 @param sureTitle 确定按钮的文字
 @param cancelTitle 取消按钮的文字
 @param confirmHandler 确认回调
 @param cancleHandler 取消回调
 */
+(void)alertDestructionTitle:(NSString *)title
                     Mesasge:(NSString *)message
                   sureTitle:(NSString *)sureTitle
                 cancelTitle:(NSString *)cancelTitle
              confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
               cancleHandler:(void(^)(UIAlertAction *action))cancleHandler;


/**
 单个选项普通样式

 @param title 主标题
 @param message 副标题
 @param actionTitle 选项文字
 @param confirmHandler 点击完成回调
 */
+(void)alertSingleActionAtTitle:(NSString *)title
                        message:(NSString *)message
                    actionTitle:(NSString *)actionTitle
                 confirmHandler:(void(^)(UIAlertAction *action))confirmHandler;



/**
 底部弹出普通样式

 @param title 标题
 @param message 副标题
 @param suretitle 确定按钮文字
 @param canceltitle 取消按钮文字
 @param confirmHandler 点击完成回调
 */
+(void)alertShootActionAtTitle:(NSString *)title
                       message:(NSString *)message
                     sureTitle:(NSString *)suretitle
                   cancelTitle:(NSString *)canceltitle
                confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
                 cancelHandler:(void(^)(UIAlertAction *action))cencelHandler;



/**
 底部弹出两个按钮样式

 @param title 主标题
 @param message 副标题
 @param fristtitle 第一个按钮title
 @param secondTitle 第二个按钮title
 @param canceltitle 取消按钮文字
 @param fristHandler 第一个按钮回调
 @param secondHandler 第二个按钮回调
 @param cencelHandler 取消按钮回调
 */
+(void)alertShootTwoActionAtTitle:(NSString *)title
                          message:(NSString *)message
                       fristTitle:(NSString *)fristtitle
                      secondTitle:(NSString *)secondTitle
                      cancelTitle:(NSString *)canceltitle
                     fristHandler:(void (^)(UIAlertAction *action))fristHandler
                    secondHandler:(void (^)(UIAlertAction *action))secondHandler
                    cancelHandler:(void (^)(UIAlertAction *action))cencelHandler;

@end
