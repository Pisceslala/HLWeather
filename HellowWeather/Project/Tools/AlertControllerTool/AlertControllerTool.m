//
//  AlertControllerTool.m
//  Project
//
//  Created by Jason.Jun on 2017/2/24.
//  Copyright © 2017年 hongsi. All rights reserved.
//

#import "AlertControllerTool.h"

@implementation AlertControllerTool



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
      cancleHandler:(void(^)(UIAlertAction *action))cancleHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:cancleHandler];
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [confirmAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [[self appRootViewController] presentViewController:alertController animated:YES completion:nil];
    
}


/**
 左普通 右销毁样式
 @param message 内容
 @param sureTitle 确定按钮的文字
 @param cancelTitle 取消按钮的文字
 @param confirmHandler 确认回调
 @param cancleHandler 取消回调
 */
+(void)alertDestructionTitle:(NSString *)title Mesasge:(NSString *)message
                     sureTitle:(NSString *)sureTitle
                   cancelTitle:(NSString *)cancelTitle
                confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
                 cancleHandler:(void(^)(UIAlertAction *action))cancleHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDestructive handler:confirmHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:cancleHandler];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [[self appRootViewController] presentViewController:alertController animated:YES completion:nil];
    
}

+(void)alertSingleActionAtTitle:(NSString *)title
                        message:(NSString *)message
                    actionTitle:(NSString *)actionTitle
                 confirmHandler:(void(^)(UIAlertAction *action))confirmHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:confirmHandler];
    
    [alertController addAction:Action];
    
    [[self appRootViewController] presentViewController:alertController animated:YES completion:nil];
    
    
}

+(void)alertShootActionAtTitle:(NSString *)title
                       message:(NSString *)message
                     sureTitle:(NSString *)suretitle
                   cancelTitle:(NSString *)canceltitle
                confirmHandler:(void (^)(UIAlertAction *))confirmHandler
                 cancelHandler:(void (^)(UIAlertAction *))cencelHandler {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleCancel handler:cencelHandler];
    [confirmAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    
    [[self appRootViewController] presentViewController:alertVC animated:YES completion:nil];
    
}

+(void)alertShootTwoActionAtTitle:(NSString *)title
                          message:(NSString *)message
                       fristTitle:(NSString *)fristtitle
                      secondTitle:(NSString *)secondTitle
                      cancelTitle:(NSString *)canceltitle
                     fristHandler:(void (^)(UIAlertAction *))fristHandler
                    secondHandler:(void (^)(UIAlertAction *))secondHandler
                    cancelHandler:(void (^)(UIAlertAction *))cencelHandler {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *fristAction = [UIAlertAction actionWithTitle:fristtitle style:UIAlertActionStyleDefault handler:fristHandler];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:secondHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleCancel handler:cencelHandler];
    [secondAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [fristAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVC addAction:fristAction];
    [alertVC addAction:secondAction];
    [alertVC addAction:cancelAction];
    
    [[self appRootViewController] presentViewController:alertVC animated:YES completion:nil];
    
}

+ (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

@end






