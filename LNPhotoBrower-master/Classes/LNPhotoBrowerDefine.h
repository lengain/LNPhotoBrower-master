//
//  LNPhotoBrowerDefine.h
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/18.
//  Copyright © 2018年 lengain. All rights reserved.
//

#ifndef LNPhotoBrowerDefine_h
#define LNPhotoBrowerDefine_h

typedef NS_ENUM(NSInteger,LNImageBrowerTransitionStyle) {
    LNImageBrowerTransitionStylePush,
    LNImageBrowerTransitionStyleZoom,
    LNImageBrowerTransitionStyleEaseInEaseOut,
};

#define LNScreenHeight    [[UIScreen mainScreen]bounds].size.height
#define LNScreenWidth     [[UIScreen mainScreen]bounds].size.width

#define LNWeakify(var) __weak typeof(var) ZFLWeak_##var = var;
#define LNStrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = ZFLWeak_##var; \
_Pragma("clang diagnostic pop")

#endif /* LNPhotoBrowerDefine_h */
