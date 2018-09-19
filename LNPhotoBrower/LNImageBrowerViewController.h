//
//  LNImageBrowerViewController.h
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/16.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNImagePickIndexModel.h"
#import "LNPhotoBrowerDefine.h"
@class LNImageBrowerViewController;
@protocol LNImageBrowerViewControllerDataSource <NSObject>

@optional
- (NSInteger)numberOfImages;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController image:(void (^)(UIImage *))image atIndex:(NSInteger)index;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController thumbImage:(void (^)(UIImage *))image atIndex:(NSInteger)index;
- (UIImageView *)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController sourceImageViewAtIndex:(NSInteger)index;
- (NSURL *)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController URLAtIndex:(NSInteger)index;

@end

@protocol LNImageBrowerViewControllerDelegate <NSObject>
@optional
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController didLongPressGestureOnImageAtIndex:(NSInteger)index;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController didSelectedImageAtIndex:(NSInteger)index;
- (void)imageBrowerViewDidConfirm:(LNImageBrowerViewController *)imageBrowerViewController;

@end

@interface LNImageBrowerViewController : UIViewController

@property (nonatomic, weak) id <LNImageBrowerViewControllerDataSource> dataSocure;
@property (nonatomic, weak) id <LNImageBrowerViewControllerDelegate> delegate;

/**
 image URL string array (data source), it will invalid when you implement the LNImageBrowerViewControllerDataSource protocol.
 */
@property (nonatomic, strong) NSArray <NSString *>*dataSourceArray;

/**
 show method
 
 @param viewController visableViewController
 @param currentIndex index of current image.
 @param style transitionStyle
 if style is LNImageBrowerTransitionStyleZoom, procotol LNImageBrowerViewControllerDataSource's method 'imageBrowerViewController:sourceImageViewAtIndex:' must be implemented.
 */
- (void)showImageBrowerWithViewController:(UIViewController *)viewController currentIndex:(NSInteger)currentIndex style:(LNImageBrowerTransitionStyle)style;

@end


