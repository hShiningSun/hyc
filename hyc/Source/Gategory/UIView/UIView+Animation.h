//
//  UIView+Animation.h
//  voiceDemo_hyc
//
//  Created by ychou on 2017/8/2.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

/**
 *  水滴动画
 */
- (void) doWaterAnimation : (NSObject *)target :(CGFloat)time;

/**
 * 暂停动画
 */

- (void) pausedAnimation;


/**
 * 继续动画
 */
- (void) continueAnimation;
@end
