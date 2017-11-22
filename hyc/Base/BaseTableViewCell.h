//
//  BaseTableViewCell.h
//  voiceDemo_hyc
//
//  Created by ychou on 2017/7/27.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/** 加载这个cell的tableView */
@property (nonatomic, strong,readonly) UITableView *tableView;

@property (nonatomic,strong) NSObject *model;

/** 
 *  公共配置 
 */
- (void) doSetup;

- (void) setCellModel:(NSObject *)model;
@end
