//
//  LNImageBrowerViewController.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/16.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNImageBrowerViewController.h"
#import "LNImageBrowerThumbImageView.h"
#import "LNImageBrowerCollectionViewCell.h"
#define kBrowseSpace 20.0f
#import "LNImageBrowerAnimatedTransitioning.h"
@interface LNImageBrowerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LNImageBrowerItemGestureMonitor,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger beginningIndex;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILabel *imageCountIndicatorLabel;
@property (nonatomic, assign) LNImageBrowerTransitionStyle style;
@property (nonatomic, strong) LNImageBrowerAnimatedTransitioning *animatedTransitioning;

@end

@implementation LNImageBrowerViewController

static NSString *LNImageBrowerCollectionViewCellReuseId = @"LNImageBrowerCollectionViewCell";

- (instancetype)init {
    self = [super init];
    if (self) {
        //        _showImageCountIndicator = YES;
        _currentIndex = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    if (self.style == LNImageBrowerTransitionStyleZoom) {
        UIWindow *currentWindow = (UIWindow *)self.nextResponder.nextResponder;
        currentWindow.backgroundColor = [UIColor clearColor];//UITransitionView
        for (UIView *view in currentWindow.subviews) {
            if (view!=self.view) {
                view.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

#pragma mark - Methods
- (void)prepareForView {
    [self.view addSubview:self.collectionView];
    [self.view insertSubview:self.collectionView atIndex:0];
    [self.collectionView reloadData];
    NSInteger maxCount;
    if ([self.dataSocure respondsToSelector:@selector(numberOfImages)]) {
        maxCount = [self.dataSocure numberOfImages];
    }else if (self.dataSourceArray && self.dataSourceArray.count) {
        maxCount = [self.dataSourceArray count];
    }else {
        maxCount = 0;
    }
    if (self.beginningIndex >= maxCount) {
        self.beginningIndex = 0;
    }
    [self.collectionView setContentOffset:CGPointMake(self.beginningIndex * self.collectionView.frame.size.width, 0)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)showImageBrowerWithViewController:(UIViewController *)viewController currentIndex:(NSInteger)currentIndex style:(LNImageBrowerTransitionStyle)style {
    self.style = style;
    self.beginningIndex = currentIndex;
    self.currentIndex = currentIndex;
    self.animatedTransitioning.style = style;

    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [viewController presentViewController:self animated:YES completion:nil];
}

- (void)dismiss {
    if (self.style == LNImageBrowerTransitionStyleZoom) {
        LNWeakify(self);
        self.animatedTransitioning.zoomOutImageSourceBlock = ^UIImageView *{
            LNStrongify(self);
            LNImageBrowerCollectionViewCell *cell = [[self.collectionView visibleCells] firstObject];
            return cell.browerItem.imageView;
        };
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    //    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Action

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    
}

#pragma mark - Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LNImageBrowerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LNImageBrowerCollectionViewCellReuseId forIndexPath:indexPath];
    cell.browerItem.monitor = self;
    cell.browerItem.style = self.style;
    if ([self.dataSocure respondsToSelector:@selector(imageBrowerViewController:image:atIndex:)]) {
        __weak __typeof(cell) weakCell = cell;
        [self.dataSocure imageBrowerViewController:self image:^(UIImage *image) {
            [weakCell.browerItem setImage:image];
        } atIndex:indexPath.item];
    }else if ([self.dataSocure respondsToSelector:@selector(imageBrowerViewController:URLAtIndex:)]) {
        [cell.browerItem setImageURL:[self.dataSocure imageBrowerViewController:self URLAtIndex:indexPath.row]];
    }else if (self.dataSourceArray){
        [cell.browerItem setImageURL:[NSURL URLWithString:[self.dataSourceArray objectAtIndex:indexPath.row]]];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSocure && [self.dataSocure respondsToSelector:@selector(numberOfImages)]) {
        return [self.dataSocure numberOfImages];
    }else if (self.dataSourceArray) {
        return self.dataSourceArray.count;
    }else {
        return 0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSInteger maxCount;
    if ([self.dataSocure respondsToSelector:@selector(numberOfImages)]) {
        maxCount = [self.dataSocure numberOfImages];
    }else if (self.dataSourceArray) {
        maxCount = self.dataSourceArray.count;
    }else {
        maxCount = 0;
    }
    index = MIN(index, maxCount);
    if (self.currentIndex != index) {
        self.currentIndex = index;
    }
}

#pragma mark LNImageBrowerItemGestureDelegate

- (void)imageBrowerItemDidTap:(LNImageBrowerItem *)imageBrowerItem {
    [self dismiss];
}

- (void)imageBrowerItemDidLongPress:(LNImageBrowerItem *)imageBrowerItem {
    if ([self.delegate respondsToSelector:@selector(imageBrowerViewController:didLongPressGestureOnImageAtIndex:)]) {
        [self.delegate imageBrowerViewController:self didLongPressGestureOnImageAtIndex:self.currentIndex];
    }
}

- (void)imageBrowerItemDidScroll:(LNImageBrowerItem *)imageBrowerItem {
    if (imageBrowerItem.contentOffset.y < 0) {
        
    }
}

- (void)imageBrowerItemZooming:(LNImageBrowerItem *)imageBrowerItem scale:(CGFloat)scale {
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:scale];
}

- (void)imageBrowerItemDismiss:(LNImageBrowerItem *)imageBrowerItem {
    [self dismiss];
}

#pragma mark  UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animatedTransitioning.viewAppear = YES;
    return self.animatedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animatedTransitioning.viewAppear = NO;
    return self.animatedTransitioning;
}

#pragma mark - UINavigationControllerDelegate

//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.animatedTransitioning.viewAppear = YES;
        return self.animatedTransitioning;
    }else {
        self.animatedTransitioning.viewAppear = NO;
        return self.animatedTransitioning;
    }
}

#pragma mark - Getters Setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width + kBrowseSpace, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0,*)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_collectionView registerClass:[LNImageBrowerCollectionViewCell class] forCellWithReuseIdentifier:LNImageBrowerCollectionViewCellReuseId];
    }
    return _collectionView;
}

- (UIImageView *)zoomImageView {
    if (!_zoomImageView) {
        _zoomImageView = [[UIImageView alloc] init];
    }
    return _zoomImageView;
}

- (LNImageBrowerAnimatedTransitioning *)animatedTransitioning {
    if (!_animatedTransitioning) {
        _animatedTransitioning = [[LNImageBrowerAnimatedTransitioning alloc] init];
        LNWeakify(self);
        _animatedTransitioning.zoomInImageSourceBlock = ^UIImageView *{
            LNStrongify(self);
            if (self.dataSocure && [self.dataSocure respondsToSelector:@selector(imageBrowerViewController:sourceImageViewAtIndex:)]) {
                return [self.dataSocure imageBrowerViewController:self sourceImageViewAtIndex:self.currentIndex];
            }else {
                return [UIImageView new];
            }
        };
    }
    return _animatedTransitioning;
}


//- (void)setShowImageCountIndicator:(BOOL)showImageCountIndicator {
//    _showImageCountIndicator = showImageCountIndicator;
//    if (showImageCountIndicator) {
//
//    }
//}

- (UILabel *)imageCountIndicatorLabel {
    if (!_imageCountIndicatorLabel) {
        _imageCountIndicatorLabel = [[UILabel alloc] init];
        _imageCountIndicatorLabel.textColor = [UIColor whiteColor];
        _imageCountIndicatorLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _imageCountIndicatorLabel;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


