//
//  NSString+helper.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "NSString+kvohelper.h"

@implementation NSString (kvohelper)

/**
 *  将字符串 按.分割成数组
 */
- (NSArray *)keyPathComponents {
    if (self.length == 0) {
        return nil;
    }
    return [self componentsSeparatedByString:@"."];
}


/**
 *  将字符串 按传入的数组分割成数组
 */
- (NSArray *)keyPathComponents:(NSString *)st {
    if (self.length == 0) {
        return nil;
    }
    return [self componentsSeparatedByString:@"st"];
}


- (NSString *)keyPathByDeletingFirstKeyPathComponent {
    NSUInteger firstDotIndex = [self rangeOfString:@"."].location;
    if (firstDotIndex == NSNotFound) {
        return nil;
    }
    return [self substringFromIndex:firstDotIndex + 1];
}
@end
