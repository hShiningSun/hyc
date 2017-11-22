//
//  UIButton+Action.m
//  threeT
//
//  Created by Admin on 2017/1/3.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "UIButton+Action.h"
@interface UIButton()

@property (nonatomic, copy) void(^clickBtnBlock)(id sender);

@end
@implementation UIButton (Action)

static char * _clickBlock = "_clickBlock";
static char * _titleNormal = "_titleNormal";
static char * _titleColorNormal = "_titleColorNormal";
static char * _titleColorSelect = "_titleColorSelect";

- (void) eventTouchUpInSide:(void(^)())actionBlock
{
    
    [self addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.clickBtnBlock = actionBlock;
}

- (void) clickBtn:(id)sender
{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(sender);
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


// titleNormal

- (NSString *)titleNormal
{
    return self.titleLabel.text;//objc_getAssociatedObject(self, _titleNormal);
}

- (void)setTitleNormal:(NSString *)titleNormal
{
    objc_setAssociatedObject(self, _titleNormal, titleNormal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:titleNormal forState:UIControlStateNormal];
}

// colorNormal

- (UIColor *)titleColorNormal
{
    return objc_getAssociatedObject(self, _titleColorNormal);
}

- (void)setTitleColorNormal:(UIColor *)titleColorNormal
{
    objc_setAssociatedObject(self, _titleColorNormal, titleColorNormal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitleColor:titleColorNormal forState:UIControlStateNormal];
}

// colorSelect

- (UIColor *)titleColorSelect
{
    return objc_getAssociatedObject(self, _titleColorSelect);
}

- (void)setTitleColorSelect:(UIColor *)titleColorSelect
{
    objc_setAssociatedObject(self, _titleColorSelect, titleColorSelect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitleColor:titleColorSelect forState:UIControlStateHighlighted];
}
@end

