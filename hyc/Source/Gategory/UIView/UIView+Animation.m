//
//  UIView+Animation.m
//  voiceDemo_hyc
//
//  Created by ychou on 2017/8/2.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)


/// 水滴动画
- (void) doWaterAnimation : (NSObject *)target :(CGFloat)time
{
    CATransition *waterAnimation = [CATransition animation];
    waterAnimation.duration = time;
    waterAnimation.delegate = target;
    waterAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    waterAnimation.removedOnCompletion = NO;
    waterAnimation.fillMode = kCAFillModeForwards;
    waterAnimation.type=@"rippleEffect"; // 水滴
    //    waterAnimation.subtype=kCATransitionFromRight;//右边翻转
    [self.layer addAnimation:waterAnimation forKey:@"waterAnimation"];
    
}



// 暂停动画
- (void) pausedAnimation
{
    CALayer *layer = self.layer;
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}


// 继续动画
- (void) continueAnimation
{
    CALayer *layer = self.layer;
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end
