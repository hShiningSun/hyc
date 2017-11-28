//
//  hKVOFunction.h
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//
typedef void (^RACKVOBlock)(id target, id observer, NSDictionary *change);

#import <Foundation/Foundation.h>

@interface hKVOFunction : NSObject

- (instancetype)initWithTarget:(__weak NSObject *)target observer:(__weak NSObject *)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(RACKVOBlock)block;


- (void)dispose;
@end
