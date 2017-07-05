//
//  HLPresentAnimator.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/5.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLPresentAnimator.h"

@implementation HLPresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //要转到的View
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //管理容器
    UIView *containerView = [transitionContext containerView];
    
    toView.frame = containerView.bounds;
    
    toView.alpha = 0.0f;
    
    toView.JYD_Y = CGRectGetMaxY(containerView.frame);
    
    containerView.alpha = 0.0f;
    
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        toView.alpha = 1.0f;
        containerView.alpha = 1.0f;
        toView.JYD_Y = SSScreenH /2.0;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];
}

@end
