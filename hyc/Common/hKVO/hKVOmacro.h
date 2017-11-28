//
//  hKVO.h
//  Finance
//
//  Created by ychou on 2017/11/27.
//
//

#ifndef hKVOmacro_h
#define hKVOmacro_h

#define keypath_(...) \
hmacro_if_eq(1, hmacro_argcount(__VA_ARGS__))(keypath11(__VA_ARGS__))(keypath12(__VA_ARGS__))

#define keypath11(PATH) \
(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define keypath12(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))


/**
 * 展开后返回A和B
 */
#define  hmacro_connect(A, B) \
         hmacro_connect_(A, B)


/**
 * 从第零个开始返回变量参数，最多20个
 * @param       ...         缺省参数动态可变
 * @param   __VA_ARGS__     接收缺省参数
 * @param   这里为了解决多个   用了递归的思想
 */
#define  hmacro_at(N, ...) \
         hmacro_connect(hmacro_at, N)(__VA_ARGS__)



/**
 * 参数计算 最多20个
 * http://p99.gforge.inria.fr
 */
#define hmacro_argcount(...) \
        hmacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

/**
 * 处理索引
 */

#define hmacro_if_eq(A, B) \
        hmacro_connect(hmacro_if_eq, A)(B)



/**
 *  仙人哦，不写
 */
#define hmacro_head(...) \
hmacro_head_(__VA_ARGS__, 0)

#define hmacro_dec(VAL) \
hmacro_at(VAL, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)


#define hmacro_connect_(A, B) A ## B
//#define hmacro_foreach_iter(INDEX, MACRO, ARG) MACRO(INDEX, ARG)
#define hmacro_head_(FIRST, ...) FIRST
//#define hmacro_tail_(FIRST, ...) __VA_ARGS__
//#define hmacro_consume_(...)
#define hmacro_expand_(...) __VA_ARGS__



// hmacro_at expansions
#define hmacro_at0(...) hmacro_head(__VA_ARGS__)
#define hmacro_at1(_0, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at2(_0, _1, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at3(_0, _1, _2, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at4(_0, _1, _2, _3, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at5(_0, _1, _2, _3, _4, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at6(_0, _1, _2, _3, _4, _5, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at7(_0, _1, _2, _3, _4, _5, _6, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at8(_0, _1, _2, _3, _4, _5, _6, _7, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at9(_0, _1, _2, _3, _4, _5, _6, _7, _8, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at10(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at11(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at12(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at13(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at14(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at15(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at16(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at17(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at18(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at19(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, ...) hmacro_head(__VA_ARGS__)
#define hmacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) hmacro_head(__VA_ARGS__)




// hmacro_if_eq expansions
#define hmacro_if_eq0(VALUE) \
hmacro_connect(hmacro_if_eq0_, VALUE)

#define hmacro_if_eq0_0(...) __VA_ARGS__ hmacro_consume_
#define hmacro_if_eq0_1(...) hmacro_expand_
#define hmacro_if_eq0_2(...) hmacro_expand_
#define hmacro_if_eq0_3(...) hmacro_expand_
#define hmacro_if_eq0_4(...) hmacro_expand_
#define hmacro_if_eq0_5(...) hmacro_expand_
#define hmacro_if_eq0_6(...) hmacro_expand_
#define hmacro_if_eq0_7(...) hmacro_expand_
#define hmacro_if_eq0_8(...) hmacro_expand_
#define hmacro_if_eq0_9(...) hmacro_expand_
#define hmacro_if_eq0_10(...) hmacro_expand_
#define hmacro_if_eq0_11(...) hmacro_expand_
#define hmacro_if_eq0_12(...) hmacro_expand_
#define hmacro_if_eq0_13(...) hmacro_expand_
#define hmacro_if_eq0_14(...) hmacro_expand_
#define hmacro_if_eq0_15(...) hmacro_expand_
#define hmacro_if_eq0_16(...) hmacro_expand_
#define hmacro_if_eq0_17(...) hmacro_expand_
#define hmacro_if_eq0_18(...) hmacro_expand_
#define hmacro_if_eq0_19(...) hmacro_expand_
#define hmacro_if_eq0_20(...) hmacro_expand_

#define hmacro_if_eq1(VALUE) hmacro_if_eq0(hmacro_dec(VALUE))
#define hmacro_if_eq2(VALUE) hmacro_if_eq1(hmacro_dec(VALUE))
#define hmacro_if_eq3(VALUE) hmacro_if_eq2(hmacro_dec(VALUE))
#define hmacro_if_eq4(VALUE) hmacro_if_eq3(hmacro_dec(VALUE))
#define hmacro_if_eq5(VALUE) hmacro_if_eq4(hmacro_dec(VALUE))
#define hmacro_if_eq6(VALUE) hmacro_if_eq5(hmacro_dec(VALUE))
#define hmacro_if_eq7(VALUE) hmacro_if_eq6(hmacro_dec(VALUE))
#define hmacro_if_eq8(VALUE) hmacro_if_eq7(hmacro_dec(VALUE))
#define hmacro_if_eq9(VALUE) hmacro_if_eq8(hmacro_dec(VALUE))
#define hmacro_if_eq10(VALUE) hmacro_if_eq9(hmacro_dec(VALUE))
#define hmacro_if_eq11(VALUE) hmacro_if_eq10(hmacro_dec(VALUE))
#define hmacro_if_eq12(VALUE) hmacro_if_eq11(hmacro_dec(VALUE))
#define hmacro_if_eq13(VALUE) hmacro_if_eq12(hmacro_dec(VALUE))
#define hmacro_if_eq14(VALUE) hmacro_if_eq13(hmacro_dec(VALUE))
#define hmacro_if_eq15(VALUE) hmacro_if_eq14(hmacro_dec(VALUE))
#define hmacro_if_eq16(VALUE) hmacro_if_eq15(hmacro_dec(VALUE))
#define hmacro_if_eq17(VALUE) hmacro_if_eq16(hmacro_dec(VALUE))
#define hmacro_if_eq18(VALUE) hmacro_if_eq17(hmacro_dec(VALUE))
#define hmacro_if_eq19(VALUE) hmacro_if_eq18(hmacro_dec(VALUE))
#define hmacro_if_eq20(VALUE) hmacro_if_eq19(hmacro_dec(VALUE))


#endif /* hKVOmacro_h */









