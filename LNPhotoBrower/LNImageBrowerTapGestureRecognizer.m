//
//  LNImageBrowerTapGestureRecognizer.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/23.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerTapGestureRecognizer.h"

@implementation LNImageBrowerTapGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       // Enough time has passed and the gesture was not recognized -> It has failed.
       if  (self.state != UIGestureRecognizerStateRecognized) {
           self.state = UIGestureRecognizerStateFailed;
       }
    });
}

@end
