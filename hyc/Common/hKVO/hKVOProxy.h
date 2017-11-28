//
//  hKVOProxy.h
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import <Foundation/Foundation.h>

@interface hKVOProxy : NSObject

/**
 *  单例
 */
+ (instancetype)sharedProxy;

/**
 * 添加kvo
 */
- (void)addObserver:(__weak NSObject *)observer forContext:(void *)context;

/**
 * 移除kvo
 */
- (void)removeObserver:(NSObject *)observer forContext:(void *)context;


@end
