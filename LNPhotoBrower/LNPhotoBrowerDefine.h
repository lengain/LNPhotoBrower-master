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

bool iPhoneNotchScreen() {
    if (__IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_11_0) {
        return false;
    }
    CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
            }
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
    }
    return iPhoneNotchDirectionSafeAreaInsets > 20;
}


/*----------------------屏幕高/宽-----------------------*/
#define LNScreenHeight    [[UIScreen mainScreen]bounds].size.height
#define LNScreenWidth     [[UIScreen mainScreen]bounds].size.width
#define LNiPhoneNotchScreen  iPhoneNotchScreen()
#define LNStatusBarHeight (LNiPhoneNotchScreen ? 44.f : 20.f)
#define LNNavigationBarHeight (LNStatusBarHeight + 44.f)
#define LNScreenHeightNoNavigationBar (LNScreenHeight - LNNavigationBarHeight)
#define LNiPhoneNotchHeight (LNiPhoneNotchScreen ? 31.f : 0.f)

/*----------------------控件高-----------------------*/
#define kTabBarHeight (LNiPhoneNotchScreen ? 83.f : 49.f)
#define kToolBarHeight              (LNiPhoneNotchScreen ? 83.f : 49.f)
#define kToolBarContentHeight       49.f
#define kHomeBarHeight (kToolBarHeight - kToolBarContentHeight)

//weak
#define LNWeakify(var) __weak typeof(var) ZFLWeak_##var = var;
//strong
#define LNStrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = ZFLWeak_##var; \
_Pragma("clang diagnostic pop")

#endif /* LNPhotoBrowerDefine_h */
