//
//  LNImageBrowerActivityIndicatorView.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/20.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerActivityIndicatorView.h"
#import "LNPhotoBrowerDefine.h"
@interface LNImageBrowerActivityIndicatorView ()


@end

@implementation LNImageBrowerActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initForViewWithFrame:frame];
    }
    return self;
}

- (void)initForViewWithFrame:(CGRect)frame {
    [self addSubview:self.activityIndicatorView];
    CGFloat indicatorViewWidth = 40.f;
    [self.activityIndicatorView setFrame:CGRectMake((frame.size.width - indicatorViewWidth)/2.f, (frame.size.height - indicatorViewWidth)/2.f, indicatorViewWidth, indicatorViewWidth)];
}

- (void)show {
    self.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)dismiss {
    [self.activityIndicatorView stopAnimating];
    self.hidden = YES;
}

- (void)dismissWithError:(NSError *)error {
    [self dismiss];
}

- (void)setProgress:(CGFloat)progress {
    //set your indicator view progress
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
