//
//  NSObject+KVO.m
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import "NSObject+KVO.h"
#import "hKVORuntimeRxtensions.h"
#import "hKVOProxy.h"
#import "NSString+kvohelper.h"





@implementation NSObject (KVO)
static char * _blockObserve = "_blockObserve";

- (instancetype) hValueForKeyPath:(NSString *)keyPath observer:(__weak NSObject *)observer
{
//    NSObject *strongObserver = observer;
    keyPath = [keyPath copy];
    
    NSArray * keyPathComponents = keyPath.keyPathComponents;
//    NSString *keyPathHead = keyPathComponents[0];
//    NSString *keyPathTail = keyPath.keyPathByDeletingFirstKeyPathComponent;
    
    
//    BOOL shouldAddDeallocObserver = NO;
    
    // 获取属性
//    objc_property_t property = class_getProperty(object_getClass(self), keyPathHead.UTF8String);
//    if (property != NULL) {
//        
//        // 获取字段
//        hKVO_propertyAttributes *attributes = hKVO_copyPropertyAttributes(property);
//        
//        if (attributes != NULL) {
//            
//            BOOL isObject = attributes->objectClass != nil || strstr(attributes->type, @encode(id)) == attributes->type;
//            BOOL isProtocol = attributes->objectClass == NSClassFromString(@"Protocol");
//            BOOL isBlock = strcmp(attributes->type, @encode(void(^)())) == 0;
//            BOOL isWeak = attributes->weak;
//            /*
//             如果这个属性实际上不是一个对象(或者是一个类对象)，
//             没有必要观察包装器返回的位置
//             现有的。
//             
//             如果这个属性是一个对象，但没有声明“弱”，我们
//             不需要看它自动被设置为nil。
//             
//             试图观察非弱性质的结果
//       。
//             */
//            shouldAddDeallocObserver = isObject && isWeak && !isBlock && !isProtocol;
//            
//            
//        }
//        
//        free(attributes);
//    }
//    else
//    {
//        
//    }
    // observer  注册的类
    // self 注册的属性
    // keyPath 从属性到字段
    
    NSKeyValueObservingOptions trampolineOptions = (NSKeyValueObservingOptionNew);//(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionPrior) & ~NSKeyValueObservingOptionInitial;

    
    // 嘿嘿这里很精髓，我们把kvo的生命周期 注册到 observer上面，跟普通kvo一样,当observer  dealloc的时候 就自动注销kvo
    hKVOFunction * kvoLifi = [[hKVOFunction alloc]initWithTarget:self observer:observer keyPath:keyPath options:trampolineOptions block:^(id target, id observer, NSDictionary *change) {
        if (self.blockObserve) {
            self.blockObserve(change[@"new"]);
        }
    }];
    
    if (observer.arrKvoLifis==nil) observer.arrKvoLifis = [NSMutableArray array];
    [observer.arrKvoLifis addObject:kvoLifi];
    
    return self;
}
- (void)block:(void (^)(id value))block
{
    self.blockObserve = block;
}

- (void (^)(id value))blockObserve
{
    return  objc_getAssociatedObject(self, _blockObserve);
}

- (void)setBlockObserve:(void (^)(id value))blockObserve
{
    objc_setAssociatedObject(self, _blockObserve, blockObserve, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end


@implementation NSObject (KVOLifi)
static char * _arrKvoLifis = "_arrKvoLifis";

- (NSMutableArray *)arrKvoLifis
{
    return  objc_getAssociatedObject(self, _arrKvoLifis);
}
- (void)setArrKvoLifis:(NSMutableArray *)arrKvoLifis
{
    objc_setAssociatedObject(self, _arrKvoLifis, arrKvoLifis, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
