//
//  hButton.h
//  HomeForPets
//
//  Created by Admin on 2016/11/13.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hButton : UIButton

/**
 *  创建按钮的时候添加到目标视图
 */
- (instancetype)initWithTargetView:(UIView*)View;

/// 是否开启点击效果
@property (nonatomic) BOOL enableHighlightedAnimation;


/// 是否圆角
@property (nonatomic) BOOL isRound;


/// 是否圆角线
@property (nonatomic) BOOL isRoundLine;
@end
