//
//  LNImageBrowerCollectionViewCell.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/16.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerCollectionViewCell.h"

@implementation LNImageBrowerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.browerItem = [[LNImageBrowerItem alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.contentView addSubview:self.browerItem];
    }
    return self;
}

@end
