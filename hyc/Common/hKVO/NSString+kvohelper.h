//
//  NSString+helper.h
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (kvohelper)


/**
 *  将字符串 按.分割成数组
 */
- (NSArray *)keyPathComponents;

/**
 *  将字符串 按传入的数组分割成数组
 */
- (NSArray *)keyPathComponents:(NSString *)st;

/**
 * 返回第一个.后面的字符串
 */
- (NSString *)keyPathByDeletingFirstKeyPathComponent;
@end
