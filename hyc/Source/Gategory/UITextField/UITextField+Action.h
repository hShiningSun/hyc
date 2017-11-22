//
//  UITextField+Action.h
//  threeT
//
//  Created by ychou on 2017/5/11.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITextField (Action)

/** 
 * 点击return 关闭键盘
 */
- (void) closeKeyboardInClickReturn;


/**
 * 点击return 后触发的事件
 */

- (void) returnTouchUpInSide:(void(^)(void))block;
@end
