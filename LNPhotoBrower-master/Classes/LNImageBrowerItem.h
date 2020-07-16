//
//  LNImageBrowerItem.h
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/16.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNPhotoBrowerDefine.h"
NS_ASSUME_NONNULL_BEGIN

@class LNImageBrowerItem;
@protocol LNImageBrowerItemGestureMonitor <UIScrollViewDelegate>

- (void)imageBrowerItemDidTap:(LNImageBrowerItem *)imageBrowerItem;
- (void)imageBrowerItem:(LNImageBrowerItem *)imageBrowerItem didLongPress:(UILongPressGestureRecognizer *)gesture;
- (void)imageBrowerItemDidScroll:(LNImageBrowerItem *)imageBrowerItem;
- (void)imageBrowerItemZooming:(LNImageBrowerItem *)imageBrowerItem scale:(CGFloat)scale;
- (void)imageBrowerItemDismiss:(LNImageBrowerItem *)imageBrowerItem;

@end

@interface LNImageBrowerItem : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id <LNImageBrowerItemGestureMonitor> monitor;
@property (nonatomic, assign) LNImageBrowerTransitionStyle style;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *placeholderImageView;

- (void)setImage:(UIImage *)image;
- (void)setImageURL:(NSURL *)imageURL placeholderImage:(nullable UIImage *)placeholderImage;

@end
NS_ASSUME_NONNULL_END
