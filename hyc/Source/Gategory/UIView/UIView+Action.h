//
//  UIView+Action.h
//  exampleDemo
//
//  Created by ychou on 2017/11/20.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIView (Action)
// 快捷单击事件
- (void) eventTouchUpInSide:(void(^)())actionBlock;

// 按下
- (void) eventTouchUpInSideBegan:(void(^)())actionBlock;

// 弹起
- (void) eventTouchUpInSideEnd:(void(^)())actionBlock;

// 长按
- (void) eventTouchUpInLongSide:(void(^)())actionBlock;

@end
