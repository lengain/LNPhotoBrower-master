//
//  LNImageBrowerContextTransitioning.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/22.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerAnimatedTransitioning.h"

@implementation LNImageBrowerAnimatedTransitioning

#pragma mark UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.style) {
        case LNImageBrowerTransitionStylePush:
            if (self.viewAppear) {
                UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
                [transitionContext.containerView addSubview:presentedView];
                presentedView.backgroundColor = [UIColor blackColor];
                presentedView.frame = CGRectMake(LNScreenWidth, 0, LNScreenWidth, LNScreenHeight);
                [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    presentedView.frame = CGRectMake(0, 0, LNScreenWidth, LNScreenHeight);
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:YES];
                }];
            }else {
                UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
                [transitionContext.containerView addSubview:dismissView];
                dismissView.frame = CGRectMake(0, 0, LNScreenWidth, LNScreenHeight);
                [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    dismissView.frame = CGRectMake(LNScreenWidth, 0, LNScreenWidth, LNScreenHeight);
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:YES];
                }];
            }
            break;
        case LNImageBrowerTransitionStyleZoom:{
            if (self.viewAppear) {
                UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
                presentedView.frame = CGRectMake(0, 0, LNScreenWidth, LNScreenHeight);
                
                UIImageView *sourceView = self.zoomInImageSourceBlock();
                UIView *maskView = [[UIView alloc] initWithFrame:presentedView.bounds];
                maskView.backgroundColor = [UIColor blackColor];
                maskView.alpha = 0;
                [transitionContext.containerView addSubview:maskView];
                
                CGFloat radio = 1;
                if (!sourceView.image || !sourceView || CGRectIsEmpty(sourceView.frame)) {
                    radio = MAXFLOAT;
                }else {
                    radio = sourceView.image.size.width / sourceView.image.size.height;
                }
                CGFloat imageViewHeight = LNScreenWidth / radio;
                CGFloat oraginY = (LNScreenHeight - imageViewHeight)/2;
                oraginY = (oraginY < 0) ? 0 : oraginY;
                
                CGFloat imageScale = sourceView.image.size.height / sourceView.image.size.width;
                CGFloat screenScale = [UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width;
                self.zoomImageView.contentMode = sourceView.contentMode;
                [self.zoomImageView setImage:sourceView.image];
                
                [self.zoomImageView setFrame:[sourceView convertRect:sourceView.frame toView:transitionContext.containerView]];
                self.zoomImageView.clipsToBounds = imageScale > screenScale;
                [transitionContext.containerView addSubview:self.zoomImageView];
                transitionContext.containerView.backgroundColor = [UIColor clearColor];
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    maskView.alpha = 1;
                    if (imageScale > screenScale) {
                        CGFloat imageWidth = LNScreenHeight / imageScale;
                        if (imageWidth > LNScreenWidth) {
                            imageWidth = LNScreenWidth;
                        }
                        [self.zoomImageView setFrame:CGRectMake((LNScreenWidth - imageWidth)/2.f, 0, imageWidth, LNScreenHeight)];
                    }else {
                        [self.zoomImageView setFrame:CGRectMake(0, oraginY, LNScreenWidth, imageViewHeight)];
                    }
                    transitionContext.containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
                } completion:^(BOOL finished) {
                    [self.zoomImageView removeFromSuperview];
                    self.zoomImageView = nil;
                    [maskView removeFromSuperview];
                    [transitionContext.containerView addSubview:presentedView];
                    [transitionContext completeTransition:YES];
                }];
            }else {
                UIImageView *zoomInSourceView = self.zoomInImageSourceBlock();
                self.zoomImageView.contentMode = zoomInSourceView.contentMode;
                self.zoomImageView.clipsToBounds = zoomInSourceView.clipsToBounds;
                
                UIImageView *zoomOutSourceView = self.zoomOutImageSourceBlock();
                [self.zoomImageView setImage:zoomOutSourceView.image];
                [self.zoomImageView setFrame:zoomOutSourceView.frame];
                
                [transitionContext.containerView addSubview:self.zoomImageView];
                
                UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
                dismissView.frame = CGRectMake(LNScreenWidth, 0, LNScreenWidth, LNScreenHeight);
                transitionContext.containerView.backgroundColor = dismissView.backgroundColor;
                
                [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [self.zoomImageView setFrame:[zoomInSourceView convertRect:zoomInSourceView.frame toView:transitionContext.containerView]];
                    transitionContext.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                } completion:^(BOOL finished) {
                    [self.zoomImageView removeFromSuperview];
                    self.zoomImageView = nil;
                    [transitionContext completeTransition:YES];
                }];
            }
        }
            break;
        default:
            break;
    }
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

#pragma mark - Getters

- (UIImageView *)zoomImageView {
    if (!_zoomImageView) {
        _zoomImageView = [[UIImageView alloc] init];
    }
    return _zoomImageView;
}

@end
