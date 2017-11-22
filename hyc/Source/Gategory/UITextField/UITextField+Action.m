//
//  UITextField+Action.m
//  threeT
//
//  Created by ychou on 2017/5/11.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "UITextField+Action.h"

@interface UITextField (Action)

@property (nonatomic, copy) void(^returnBlock)(void);

@end


@implementation UITextField (Action)

static char * _returnBlock = "_returnBlock";


- (void) closeKeyboardInClickReturn
{
    [self addTarget:self action:@selector(closekeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void) closekeyboard{
    [self resignFirstResponder];
}



#pragma mark  return 事件
- (void) returnTouchUpInSide:(void(^)(void))block
{
    
    self.returnBlock = block;
    [self addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void) returnAction:(id)sender
{
    if (self.returnBlock) {
        self.returnBlock();
    }
}
- (void (^)(void))returnBlock
{
    return objc_getAssociatedObject(self, _returnBlock);
}

- (void)setReturnBlock:(void (^)(void))returnBlock
{
    objc_setAssociatedObject(self, _returnBlock, returnBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end





