//
//  NSTimer+Action.m
//  exampleDemo
//
//  Created by ychou on 2017/11/21.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "NSTimer+Action.h"

@implementation NSTimer (Action)

/**
 * 暂停
 */

- (void) pausedTimer
{
    [self setFireDate:[NSDate distantFuture]];
}


/**
 * 继续
 */
- (void) continueTimer
{
     [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

@end
