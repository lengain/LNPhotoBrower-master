//
//  LNImageBrowerActivityIndicatorView.h
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/20.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNImageBrowerActivityIndicatorView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

- (void)initForViewWithFrame:(CGRect)frame;

/**
 download image progress

 @param progress the value range is 0~1, CGFloat type;
 */
- (void)setProgress:(CGFloat)progress;
- (void)show;
- (void)dismiss;
- (void)dismissWithError:(NSError *)error;

@end
