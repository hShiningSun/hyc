//
//  BaseTableViewCell.m
//  voiceDemo_hyc
//
//  Created by ychou on 2017/7/27.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface BaseTableViewCell()

@property (nonatomic, strong,readwrite) UITableView *tableView;

@end
@implementation BaseTableViewCell

- (UITableView *)tableView
{
    if (_tableView == nil && [self.superview isKindOfClass:[UITableView class]]) {
        _tableView = (UITableView *)self.superview;
    }
    return _tableView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self doSetup];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self doSetup];
}


- (void) doSetup
{
    
}

- (void)setModel:(NSObject *)model
{
    _model = model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setCellModel:(NSObject *)model{
    
}
@end
