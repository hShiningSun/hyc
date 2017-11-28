//
//  hKVORuntimeRxtensions.h
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef enum {
    /**
     * assigned.
     */
    hKVO_propertyMemoryManagementPolicyAssign = 0,
    
    /**
     * retained.
     */
    hKVO_propertyMemoryManagementPolicyRetain,
    
    /**
     * copied.
     */
    hKVO_propertyMemoryManagementPolicyCopy
} hKVO_propertyMemoryManagementPolicy;

/**
 * 属性.
 */
typedef struct {
    /**
     * 只读.
     */
    BOOL readonly;
    
    /**
     * 线程不要求安全
     */
    BOOL nonatomic;
    
    /**
     * 弱指针.
     */
    BOOL weak;
    
    /**
     * 能回收.
     */
    BOOL canBeCollected;
    
    /**
     * 属性定义.
     */
    BOOL dynamic;
    
    /**
     * 协议
     */
    hKVO_propertyMemoryManagementPolicy memoryManagementPolicy;
    
    /**
     * getter方法
     */
    SEL getter;
    
    /**
     * setter方法
     */
    SEL setter;
    
    /**
     * 成员变量
     */
    const char *ivar;
    
    /**
     * 类
     */
    Class objectClass;
    
    /**
     * 类型数组.
     */
    char type[];
} hKVO_propertyAttributes;

/**
 * 获取方法
 */
Method hKVO_getImmediateInstanceMethod (Class aClass, SEL aSelector);

/**
 * 获取字段数组，还有内存泄露，没有解决，暂时也没有用到过
 */
hKVO_propertyAttributes *hKVO_copyPropertyAttributes (objc_property_t property);

