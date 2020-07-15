//
//  LNImageBrowerItem.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/16.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerItem.h"
#import "UIImageView+WebCache.h"
#import "LNPhotoBrowerDefine.h"
#import "LNImageBrowerActivityIndicatorView.h"
#import "LNImageBrowerTapGestureRecognizer.h"
@interface LNImageBrowerItem ()

@property (nonatomic, strong) LNImageBrowerActivityIndicatorView *indicatorView;
@property (nonatomic, assign) CGPoint translationPoint;
@property (nonatomic, assign) BOOL translating;
@property (nonatomic, assign) CGRect beforeTranslationFrame;
@property (nonatomic, assign) CGPoint beforeTranslationPointInScrollView;
@property (nonatomic, assign) CGPoint beforeTranslationPointInImageView;

@end

@implementation LNImageBrowerItem

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (@available(iOS 11.0 , *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self prepareForView];
    }
    return self;
}

- (void)prepareForView {
    self.delegate = self;
    self.minimumZoomScale = 1.0f;
    self.maximumZoomScale = 3.0f;
    //it should be yes
    self.alwaysBounceVertical = YES;
    
    self.translating = NO;
    self.translationPoint = CGPointZero;
    
    [self addSubview:self.imageView];
    [self.imageView setFrame:self.bounds];
    
    LNImageBrowerTapGestureRecognizer *doubleTap = [[LNImageBrowerTapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:doubleTap];
    
    LNImageBrowerTapGestureRecognizer *singleTap = [[LNImageBrowerTapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    [self.imageView addGestureRecognizer:singleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    [self.imageView addGestureRecognizer:longPress];
    
    [self addSubview:self.indicatorView];
    
    [self addPanGestureMonitor];
}

#pragma mark - Methods


- (void)setImage:(UIImage *)image {
    if (!image) {
        return;
    }
    CGFloat radio = image.size.width / image.size.height;
    CGFloat imageViewHeight = CGRectGetWidth(self.frame) / radio;
    CGFloat oraginY = (self.frame.size.height - imageViewHeight)/2;
    if (oraginY < 0) {
        oraginY = 0;
    }
    [self.imageView setFrame:CGRectMake(0, oraginY, CGRectGetWidth(self.frame), imageViewHeight)];
    [self.imageView setImage:image];
    [self setContentSize:self.imageView.frame.size];
}

- (void)setImageURL:(NSURL *)imageURL {
    LNWeakify(self);
    [self.indicatorView show];
    [self.imageView sd_setImageWithURL:imageURL placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        LNStrongify(self);
        [self.indicatorView setProgress:(CGFloat)receivedSize / (CGFloat)expectedSize];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        LNStrongify(self);
        if (image) {
            [self setImage:image];
            [self.indicatorView dismiss];
        }else {//show error
            [self.indicatorView dismiss];
        }
    }];
}

#pragma mark - Private methods

- (void)addPanGestureMonitor {
    __weak __typeof(self) weakSelf = self;
    [self.panGestureRecognizer addTarget:weakSelf action:@selector(onPanGesture:)];
}

- (void)removePanGestureMonitor {
    __weak __typeof(self) weakSelf = self;
    [self.panGestureRecognizer removeTarget:weakSelf action:@selector(onPanGesture:)];
}

- (void)zoomDoubleTapWithPoint:(CGPoint)touchPoint {
    if (self.zoomScale > self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }else {
        CGFloat width = self.bounds.size.width / self.maximumZoomScale;
        CGFloat height = self.bounds.size.height / self.maximumZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - width / 2, touchPoint.y - height / 2, width, height) animated:YES];
    }
}

#pragma mark - Action

- (void)onDoubleTap:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self.imageView];
    [self zoomDoubleTapWithPoint:touchPoint];
}

- (void)onSingleTap:(UITapGestureRecognizer *)tapGesture {
    if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemDidTap:)]) {
        [self.monitor imageBrowerItemDidTap:self];
    }
}

- (void)onLongPress:(UILongPressGestureRecognizer *)longPressGesture {
    if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemDidLongPress:)]) {
        [self.monitor imageBrowerItemDidLongPress:self];
    }
}

- (void)onPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (self.style != LNImageBrowerTransitionStyleZoom) {
        [self removePanGestureMonitor];
        return;
    }
    UIScrollView *scrollView = (UIScrollView *)panGesture.view;
    self.translationPoint = [panGesture translationInView:scrollView];
    if (!self.translating && self.translationPoint.y > 0 && scrollView.contentOffset.y < 0 && (CGRectGetWidth(self.frame) == (NSInteger)CGRectGetWidth(self.imageView.frame))) {
        self.beforeTranslationPointInImageView = [panGesture locationInView:self.imageView];
        if (CGRectContainsPoint(self.imageView.frame, self.beforeTranslationPointInImageView)) {//如果手势作用在imageView上,则开始拖动
            self.beforeTranslationPointInScrollView = [panGesture locationInView:scrollView];
            self.translating = YES;
            self.beforeTranslationFrame = self.imageView.frame;
            [panGesture setTranslation:CGPointZero inView:scrollView];
            self.translationPoint = CGPointZero;
        }
    }
    if (self.translating) {
        if (self.translationPoint.y > 0) {//滑动方向向下,开始缩放
            CGFloat maxHeight = self.bounds.size.height;
            if (maxHeight <= 0) return;
            //缩放比例
            CGFloat scale = (1 - self.translationPoint.y / maxHeight);
            if (scale > 1) scale = 1;
            if (scale < 0) scale = 0;
            
            CGFloat width = self.beforeTranslationFrame.size.width * scale;
            CGFloat height = self.beforeTranslationFrame.size.height * scale;
            CGFloat panPointScaleX = self.beforeTranslationPointInImageView.x / self.beforeTranslationFrame.size.width;
            CGFloat panPointScaleY = self.beforeTranslationPointInImageView.y / self.beforeTranslationFrame.size.height;
            
            CGPoint currentLocationInScrollView = [panGesture locationInView:scrollView];
            self.imageView.frame = CGRectMake(currentLocationInScrollView.x - width * panPointScaleX, currentLocationInScrollView.y - height * panPointScaleY, width, height);
            
            if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemZooming:scale:)]) {
                [self.monitor imageBrowerItemZooming:self scale:scale];
            }
        }else {
            self.imageView.frame = CGRectMake(self.beforeTranslationFrame.origin.x + self.translationPoint.x, self.beforeTranslationFrame.origin.y + self.translationPoint.y, self.beforeTranslationFrame.size.width, self.beforeTranslationFrame.size.height);
            
            if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemZooming:scale:)]) {
                [self.monitor imageBrowerItemZooming:self scale:1];
            }
        }
    }
    if (panGesture.state == UIGestureRecognizerStateEnded && self.translating) {
        CGPoint velocity = [panGesture velocityInView:scrollView];
        //判断是否调起返回
        NSLog(@"velocity:%@",NSStringFromCGPoint(velocity));
        if (velocity.y > 10) {//返回
            [self removePanGestureMonitor];
            if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemDismiss:)]) {
                [self.monitor imageBrowerItemDismiss:self];
            }
        }else {//恢复
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemZooming:scale:)]) {
                    [self.monitor imageBrowerItemZooming:self scale:1];
                }
                [self.imageView setFrame:self.beforeTranslationFrame];
            } completion:^(BOOL finished) {
                self.beforeTranslationFrame = CGRectZero;
                self.translationPoint = CGPointZero;
                self.translating = NO;
            }];
        }
    }
}


#pragma mark - Delegate
#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //缩放
    CGRect rect = self.imageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.frame.size.width) {
        rect.origin.x = floorf((self.frame.size.width - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.frame.size.height) {
        rect.origin.y = floorf((self.frame.size.height - rect.size.height) / 2.0);
    }
    self.imageView.frame = rect;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.monitor && [self.monitor respondsToSelector:@selector(imageBrowerItemDidScroll:)]) {
        [self.monitor imageBrowerItemDidScroll:self];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

#pragma mark - Getters

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (LNImageBrowerActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[LNImageBrowerActivityIndicatorView alloc] initWithFrame:self.bounds];
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
