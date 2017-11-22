//
//  UIView+Action.m
//  exampleDemo
//
//  Created by ychou on 2017/11/20.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "UIView+Action.h"

@interface UIView()

@property (nonatomic, copy) void(^clickBtnBlock)(id sender);

@property (nonatomic, copy) void(^clickBeganBlock)(id sender);

@property (nonatomic, copy) void(^clickEndBlock)(id sender);

@property (nonatomic, copy) void(^longClickBtnBlock)(id sender);

@end


@implementation UIView (Action)
static char * _clickBlock = "_clickBlock";
static char * _clickBeganBlock = "_clickBeganBlock";
static char * _clickEndBlock = "_clickEndBlock";
static char * _longClickBlock = "_longClickBlock";


#pragma  mark 单击
- (void) eventTouchUpInSide:(void(^)())actionBlock
{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer*singleTap;//单击手势
    singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn:)];//初始化
    singleTap.numberOfTapsRequired=1;//轻敲次数
    [self addGestureRecognizer:singleTap];//给视图添加手势
    
    self.clickBtnBlock = actionBlock;
}


- (void) clickBtn:(UITapGestureRecognizer*)recognizer
{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(self);
        return;
    }
    
    // 按下
    if (recognizer.state == UIGestureRecognizerStateBegan && self.clickBeganBlock) {
        self.clickBeganBlock(self);
    }
    
    
    // 弹起
    if (recognizer.state == UIGestureRecognizerStateEnded && self.clickEndBlock) {
        self.clickEndBlock(self);
    }
    
}


// 点击事件
- (void (^)(id))clickBtnBlock
{
    return objc_getAssociatedObject(self, _clickBlock);
}

- (void)setClickBtnBlock:(void (^)(id))clickBtnBlock
{
    objc_setAssociatedObject(self, _clickBlock, clickBtnBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma Mark  长按

// 长按
- (void) eventTouchUpInLongSide:(void(^)())actionBlock
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [longPress setMinimumPressDuration:0.2];//按下的时间
    [self addGestureRecognizer:longPress];
    
    self.longClickBtnBlock  = actionBlock;
}

- (void) longPress:(UITapGestureRecognizer*)recognizer
{
    if (self.longClickBtnBlock) {
        self.longClickBtnBlock(self);
        return;
    }
    
    // 按下
    if (recognizer.state == UIGestureRecognizerStateBegan && self.clickBeganBlock) {
        self.clickBeganBlock(self);
    }
    
    
    // 弹起
    if (recognizer.state == UIGestureRecognizerStateEnded && self.clickEndBlock) {
        self.clickEndBlock(self);
    }
    
}
// 点击事件
- (void (^)(id))longClickBtnBlock
{
    return objc_getAssociatedObject(self, _longClickBlock);
}

- (void)setLongClickBtnBlock:(void (^)(id))longClickBtnBlock
{
    objc_setAssociatedObject(self, _longClickBlock, longClickBtnBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma Mark  按下

// 按下
- (void) eventTouchUpInSideBegan:(void(^)())actionBlock
{
    self.clickBeganBlock = actionBlock;
    [self eventTouchUpInLongSide:nil];
}

// 点击事件
- (void (^)(id))clickBeganBlock
{
    return objc_getAssociatedObject(self, _clickBeganBlock);
}

- (void)setClickBeganBlock:(void (^)(id))clickBeganBlock
{
    objc_setAssociatedObject(self, _clickBeganBlock, clickBeganBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma  mark 弹起

- (void) eventTouchUpInSideEnd:(void(^)())actionBlock
{
    self.clickEndBlock = actionBlock;
}
// 点击事件
- (void (^)(id))clickEndBlock
{
    return objc_getAssociatedObject(self, _clickEndBlock);
}

- (void)setClickEndBlock:(void (^)(id))clickEndBlock
{
    objc_setAssociatedObject(self, _clickEndBlock, clickEndBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

