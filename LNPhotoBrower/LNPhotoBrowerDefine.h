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

/*----------------------屏幕高/宽-----------------------*/
#define LNScreenHeight    [[UIScreen mainScreen]bounds].size.height
#define LNScreenWidth     [[UIScreen mainScreen]bounds].size.width
#define LNiPhoneX          (LNScreenWidth == 375.f && LNScreenHeight == 812.f ? YES : NO)
#define LNStatusBarHeight (LNiPhoneX ? 44.f : 20.f)
#define LNNavigationBarHeight (LNStatusBarHeight + 44.f)
#define LNScreenHeightNoNavigationBar (LNScreenHeight - LNNavigationBarHeight)
#define LNiPhoneXNotchHeight (LNiPhoneX ? 31.f : 0.f) //iPhone X 刘海的高度 34

/*----------------------控件高-----------------------*/
#define kTabBarHeight (LNiPhoneX ? 83.f : 49.f)
#define kToolBarHeight              (LNiPhoneX ? 83.f : 49.f)
#define kToolBarContentHeight       49.f
#define kHomeBarHeight (kToolBarHeight - kToolBarContentHeight)

//颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//弱引用
#define LNWeakify(var) __weak typeof(var) ZFLWeak_##var = var;
//强引用
#define LNStrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = ZFLWeak_##var; \
_Pragma("clang diagnostic pop")

#endif /* LNPhotoBrowerDefine_h */
