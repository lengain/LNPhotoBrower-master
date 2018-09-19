//
//  LNImageBrowerThumbImageView.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/18.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerThumbImageView.h"

@implementation LNImageBrowerThumbImageView

#pragma mark - Getter Setters

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.layer.borderWidth = (1.f / [UIScreen mainScreen].scale) * 4;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }else {
        self.layer.borderWidth = 0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
