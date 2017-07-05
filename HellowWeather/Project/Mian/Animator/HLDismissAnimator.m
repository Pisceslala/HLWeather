//
//  HLDismissAnimator.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/5.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLDismissAnimator.h"

@implementation HLDismissAnimator


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    fromView.frame = containerView.bounds;
    
    fromView.alpha = 1.0f;
    containerView.alpha = 1.0f;
    fromView.JYD_Y = SSScreenH /2.0;
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//
//        fromView.JYD_Y = CGRectGetMaxY(containerView.frame);
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.88 initialSpringVelocity:1.0 / 0.88 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromView.JYD_Y = CGRectGetMaxY(containerView.frame);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}
@end
