//
//  hKVORuntimeRxtensions.m
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#import "hKVORuntimeRxtensions.h"


#import <ctype.h>
#import <Foundation/Foundation.h>
#import <libkern/OSAtomic.h>
#import <objc/message.h>
#import <pthread.h>
#import <stdio.h>
#import <stdlib.h>
#import <string.h>

hKVO_propertyAttributes *hKVO_copyPropertyAttributes (objc_property_t property) {
    const char * const attrString = property_getAttributes(property);
    if (!attrString) {
        fprintf(stderr, "ERROR: Could not get attribute string from property %s\n", property_getName(property));
        return NULL;
    }
    
    if (attrString[0] != 'T') {
        fprintf(stderr, "ERROR: Expected attribute string \"%s\" for property %s to start with 'T'\n", attrString, property_getName(property));
        return NULL;
    }
    
    const char *typeString = attrString + 1;
    const char *next = NSGetSizeAndAlignment(typeString, NULL, NULL);
    if (!next) {
        fprintf(stderr, "ERROR: Could not read past type in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
        return NULL;
    }
    
    size_t typeLength = (size_t)(next - typeString);
    if (!typeLength) {
        fprintf(stderr, "ERROR: Invalid type in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
        return NULL;
    }
    
    // 为结构和类型字符串分配足够的空间
    hKVO_propertyAttributes *attributes = calloc(1, sizeof(hKVO_propertyAttributes) + typeLength + 1);
    if (!attributes) {
        fprintf(stderr, "ERROR: Could not allocate hKVO_propertyAttributes structure for attribute string \"%s\" for property %s\n", attrString, property_getName(property));
        return NULL;
    }
    
    // 复制字符串类型
    strncpy(attributes->type, typeString, typeLength);
    attributes->type[typeLength] = '\0';
    
    // 如果这是一个对象类型，紧接着是引用的字符串
    if (typeString[0] == *(@encode(id)) && typeString[1] == '"') {
        // 提取类名字
        const char *className = typeString + 2;
        next = strchr(className, '"');
        
        if (!next) {
            fprintf(stderr, "ERROR: Could not read class name in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
            return NULL;
        }
        
        if (className != next) {
            size_t classNameLength = (size_t)(next - className);
            char trimmedName[classNameLength + 1];
            
            strncpy(trimmedName, className, classNameLength);
            trimmedName[classNameLength] = '\0';
            
            // 运行时查找类
            attributes->objectClass = objc_getClass(trimmedName);
        }
    }
    
    if (*next != '\0') {
        // 跳过无用信息
        next = strchr(next, ',');
    }
    
    while (next && *next == ',') {
        char flag = next[1];
        next += 2;
        
        switch (flag) {
            case '\0':
                break;
                
            case 'R':
                attributes->readonly = YES;
                break;
                
            case 'C':
                attributes->memoryManagementPolicy = hKVO_propertyMemoryManagementPolicyCopy;
                break;
                
            case '&':
                attributes->memoryManagementPolicy = hKVO_propertyMemoryManagementPolicyRetain;
                break;
                
            case 'N':
                attributes->nonatomic = YES;
                break;
                
            case 'G':
            case 'S':
            {
                const char *nextFlag = strchr(next, ',');
                SEL name = NULL;
                
                if (!nextFlag) {
                    // 如果其他字符串是 方法字符串
                    const char *selectorString = next;
                    next = "";
                    
                    name = sel_registerName(selectorString);
                } else {
                    size_t selectorLength = (size_t)(nextFlag - next);
                    if (!selectorLength) {
                        fprintf(stderr, "ERROR: Found zero length selector name in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
                        goto errorOut;
                    }
                    
                    char selectorString[selectorLength + 1];
                    
                    strncpy(selectorString, next, selectorLength);
                    selectorString[selectorLength] = '\0';
                    
                    name = sel_registerName(selectorString);
                    next = nextFlag;
                }
                
                if (flag == 'G')
                    attributes->getter = name;
                else
                    attributes->setter = name;
            }
                
                break;
                
            case 'D':
                attributes->dynamic = YES;
                attributes->ivar = NULL;
                break;
                
            case 'V':
                // 如果字符串其他部分是 实例变量的名称字符串
                if (*next == '\0') {
                    // 如果没有，当成动态的
                    attributes->ivar = NULL;
                } else {
                    attributes->ivar = next;
                    next = "";
                }
                
                break;
                
            case 'W':
                attributes->weak = YES;
                break;
                
            case 'P':
                attributes->canBeCollected = YES;
                break;
                
            case 't':
                fprintf(stderr, "ERROR: Old-style type encoding is unsupported in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
                
                // 跳过这个类型
                while (*next != ',' && *next != '\0')
                    ++next;
                
                break;
                
            default:
                fprintf(stderr, "ERROR: Unrecognized attribute string flag '%c' in attribute string \"%s\" for property %s\n", flag, attrString, property_getName(property));
        }
    }
    
    if (next && *next != '\0') {
        fprintf(stderr, "Warning: Unparsed data \"%s\" in attribute string \"%s\" for property %s\n", next, attrString, property_getName(property));
    }
    
    if (!attributes->getter) {
        // 默认 使用属性名类使用getter
        attributes->getter = sel_registerName(property_getName(property));
    }
    
    if (!attributes->setter) {
        const char *propertyName = property_getName(property);
        size_t propertyNameLength = strlen(propertyName);
        
        // 将名称转化属性类型
        size_t setterLength = propertyNameLength + 4;
        
        char setterName[setterLength + 1];
        strncpy(setterName, "set", 3);
        strncpy(setterName + 3, propertyName, propertyNameLength);
        
        // 设置setter的属性名字
        setterName[3] = (char)toupper(setterName[3]);
        
        setterName[setterLength - 1] = ':';
        setterName[setterLength] = '\0';
        
        attributes->setter = sel_registerName(setterName);
    }
    
    return attributes;
    
errorOut:
    free(attributes);
    return NULL;
}


/**
 *  获取执行的方法
 */
Method hKVO_getImmediateInstanceMethod (Class aClass, SEL aSelector) {
    unsigned methodCount = 0;
    Method *methods = class_copyMethodList(aClass, &methodCount);
    Method foundMethod = NULL;
    
    for (unsigned methodIndex = 0;methodIndex < methodCount;++methodIndex) {
        if (method_getName(methods[methodIndex]) == aSelector) {
            foundMethod = methods[methodIndex];
            break;
        }
    }
    
    free(methods);
    return foundMethod;
}

