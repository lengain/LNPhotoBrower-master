//
//  LNImageBrowerContextTransitioning.h
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/22.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LNPhotoBrowerDefine.h"

typedef UIImageView * (^LNAnimatedTransitioningImageSource)(void);

@interface LNImageBrowerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

//@property (nonatomic, strong) UIView *transitionSourceView;
@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, assign) BOOL viewAppear;
@property (nonatomic, assign) LNImageBrowerTransitionStyle style;
@property (nonatomic, copy) LNAnimatedTransitioningImageSource zoomInImageSourceBlock;
@property (nonatomic, copy) LNAnimatedTransitioningImageSource zoomOutImageSourceBlock;

@end
