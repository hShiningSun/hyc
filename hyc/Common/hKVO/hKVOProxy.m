//
//  hKVOProxy.m
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import "hKVOProxy.h"

@interface hKVOProxy()

@property (strong, nonatomic, readonly) NSMapTable *trampolines;
@property (strong, nonatomic, readonly) dispatch_queue_t queue;

@end

@implementation hKVOProxy

+ (instancetype)sharedProxy {
    static hKVOProxy *proxy;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        proxy = [[self alloc] init];
    });
    
    return proxy;
}

- (instancetype)init {
    self = [super init];
    
    _queue = dispatch_queue_create("hyc.create2017-11-27.hycKVOProxy", DISPATCH_QUEUE_SERIAL);
    _trampolines = [NSMapTable strongToWeakObjectsMapTable];
    
    return self;
}

- (void)addObserver:(__weak NSObject *)observer forContext:(void *)context {
    NSValue *valueContext = [NSValue valueWithPointer:context];
    
    dispatch_sync(self.queue, ^{
        [self.trampolines setObject:observer forKey:valueContext];
    });
}

- (void)removeObserver:(NSObject *)observer forContext:(void *)context {
    NSValue *valueContext = [NSValue valueWithPointer:context];
    
    dispatch_sync(self.queue, ^{
        [self.trampolines removeObjectForKey:valueContext];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSValue *valueContext = [NSValue valueWithPointer:context];
    __block NSObject *trueObserver;
    
    dispatch_sync(self.queue, ^{
        trueObserver = [self.trampolines objectForKey:valueContext];
    });
    
    if (trueObserver != nil) {
        [trueObserver observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
