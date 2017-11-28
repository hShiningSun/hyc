//
//  hKVOFunction.m
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import "hKVOFunction.h"
#import "hKVOProxy.h"

@interface hKVOFunction()
// The keypath which the trampoline is observing.
@property (nonatomic, readonly, copy) NSString *keyPath;

// These properties should only be manipulated while synchronized on the
// receiver.
@property (nonatomic, readonly, copy) RACKVOBlock block;
@property (nonatomic, readonly, unsafe_unretained) NSObject *unsafeTarget;
@property (nonatomic, readonly, weak) NSObject *weakTarget;
@property (nonatomic, readonly, weak) NSObject *observer;


@end

@implementation hKVOFunction

- (instancetype)initWithTarget:(__weak NSObject *)target observer:(__weak NSObject *)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(RACKVOBlock)block {
    // observer 是注册kvo的类
    // target 注册的属性
    // keyPath 注册属性的第一部分 也就是最大的对象载体
    // self    也是注册的属性
    
    
    NSCParameterAssert(keyPath != nil);
    NSCParameterAssert(block != nil);
    
    NSObject *strongTarget = target;
    if (strongTarget == nil) return nil;
    
    self = [super init];
    
    _keyPath = [keyPath copy];
    
    _block = [block copy];
    _weakTarget = target;
    _unsafeTarget = strongTarget;
    _observer = observer;
    
    [hKVOProxy.sharedProxy addObserver:self forContext:(__bridge void *)self];
    [strongTarget addObserver:hKVOProxy.sharedProxy forKeyPath:self.keyPath options:options context:(__bridge void *)self];
    
    
    return self;
}



#pragma mark Observation

- (void)dispose {
    NSObject *target;
    NSObject *observer;
    
    @synchronized (self) {
        
        // 复制到 方法体内部，用完自动释放
        target = self.unsafeTarget;
        observer = self.observer;
        
        _unsafeTarget = nil;
        _observer = nil;
        _block = nil;//放到最后释放，不然把注册的类给释放了，原因不清楚
    }
    
    [target removeObserver:hKVOProxy.sharedProxy forKeyPath:self.keyPath context:(__bridge void *)self];
    [hKVOProxy.sharedProxy removeObserver:self forContext:(__bridge void *)self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context != (__bridge void *)self) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    RACKVOBlock block;
    id observer;
    id target;
    
    @synchronized (self) {
        block = self.block;
        observer = self.observer;
        target = self.weakTarget;
    }
    
    if (block == nil || target == nil) return;
    
    block(target, observer, change);
}


@end

