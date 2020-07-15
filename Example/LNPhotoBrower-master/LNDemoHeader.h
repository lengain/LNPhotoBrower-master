//
//  LNDemoHeader.h
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 7/15/20.
//  Copyright © 2020 lengain. All rights reserved.
//

#ifndef LNDemoHeader_h
#define LNDemoHeader_h

static bool iPhoneNotchScreen() {
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




#endif /* LNDemoHeader_h */
