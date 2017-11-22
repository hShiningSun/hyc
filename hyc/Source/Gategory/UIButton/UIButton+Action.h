//
//  UIButton+Action.h
//  threeT
//
//  Created by Admin on 2017/1/3.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (Action)

// 快捷单击事件
- (void) eventTouchUpInSide:(void(^)())actionBlock;

// 普通状态的文字
@property (nonatomic, strong) NSString * titleNormal;

// 普通状态的文字颜色
@property (nonatomic, strong) UIColor * titleColorNormal;

// 选中状态的文字颜色
@property (nonatomic, strong) UIColor * titleColorSelect;

@end
