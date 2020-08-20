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
#import "LNImageBrowerItem.h"
NS_ASSUME_NONNULL_BEGIN

@class LNImageBrowerViewController;
@protocol LNImageBrowerViewControllerDataSource <NSObject>

@optional
- (NSInteger)numberOfImages;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController image:(void (^)(UIImage *))image atIndex:(NSInteger)index;
- (nullable UIImage *)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController thumbImageAtIndex:(NSInteger)index;
- (nullable UIImageView *)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController sourceImageViewAtIndex:(NSInteger)index;
- (nullable NSURL *)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController URLAtIndex:(NSInteger)index;

@end

@protocol LNImageBrowerViewControllerDelegate <NSObject>

@optional
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController longPressGesture:(UILongPressGestureRecognizer *)gesture onImageAtIndex:(NSInteger)index;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController didSelectedImageAtIndex:(NSInteger)index;
- (void)imageBrowerViewDidConfirm:(LNImageBrowerViewController *)imageBrowerViewController;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController willDisplayImageBrowerItem:(LNImageBrowerItem *)item;
- (void)imageBrowerViewController:(LNImageBrowerViewController *)imageBrowerViewController didEndDisplayImageBrowerItem:(LNImageBrowerItem *)item;

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


NS_ASSUME_NONNULL_END
