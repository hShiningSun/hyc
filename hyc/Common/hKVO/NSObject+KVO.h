//
//  NSObject+KVO.h
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "hKVOmacro.h"
#import "hKVOFunction.h"

#define _hObserve(TARGET, KEYPATH) \
({ \
__weak id target_ = (TARGET); \
[target_ hValueForKeyPath:@keypath_(TARGET, KEYPATH) observer:self]; \
})

#if __clang__ && (__clang_major__ >= 8)
#define hObserve(TARGET, KEYPATH) _hObserve(TARGET, KEYPATH)
#else
#define hObserve(TARGET, KEYPATH) \
({ \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wreceiver-is-weak\"") \
_hObserve(TARGET, KEYPATH) \
_Pragma("clang diagnostic pop") \
})
#endif


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVO)
/**
 *  启动kvo的方法
 */
#if OS_OBJECT_HAVE_OBJC_SUPPORT
- (instancetype )hValueForKeyPath:(NSString *)keyPath observer:(__weak NSObject *)observer;
#else
- (instancetype )hValueForKeyPath:(NSString *)keyPath observer:(NSObject *)observer;
#endif

/**
 *  执行kvo的block
 */
- (void) block:(void(^)(id value))block;

@end
NS_ASSUME_NONNULL_END

@interface NSObject (KVOLifi)

@property (nonatomic,strong) NSMutableArray *arrKvoLifis;//hKVOFunction * _Nullable kvoLifi;

@end







