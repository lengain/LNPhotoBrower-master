//
//  LNRemoteNetViewController.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/15.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNRemoteNetPushStyleViewController.h"
#import "UIButton+WebCache.h"
#import "LNPhotoBrowerDefine.h"
#import "LNImageBrowerViewController.h"
@interface LNRemoteNetPushStyleViewController ()

@property (nonatomic, strong) NSArray <NSString *>*imageURLStringArray;

@end

@implementation LNRemoteNetPushStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    CGFloat padding = 10.f;
    CGFloat width = (LNScreenWidth - padding * 5)/4.f;
    for (NSInteger i = 0; i < self.imageURLStringArray.count ; i++) {
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageButton sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringArray[i]] forState:UIControlStateNormal];
        [imageButton setFrame:CGRectMake(padding + (padding + width) * (i % 4), LNNavigationBarHeight + padding + (padding + width) * (NSInteger)(i / 4), width, width)];
        [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.tag = i;
        [self.view addSubview:imageButton];
    }
}

- (void)imageButtonAction:(UIButton *)button {
    LNImageBrowerViewController *imageBrower = [[LNImageBrowerViewController alloc] init];
    imageBrower.dataSourceArray = self.imageURLStringArray;
    [imageBrower showImageBrowerWithViewController:self currentIndex:button.tag style:LNImageBrowerTransitionStylePush];
}

- (NSArray<NSString *> *)imageURLStringArray {
    if (!_imageURLStringArray) {
        _imageURLStringArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779709&di=4ee61b24abce9637c0e9c36ae1933bed&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201504%2F08%2F20150408H5303_GP8JU.jpeg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779708&di=cc47b0e793222ca13465436c81a8a739&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F20%2F20141120232753_KtmmF.jpeg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779708&di=d9a839aefb74ef197948553297bc93cd&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201507%2F09%2F20150709221715_tvuds.jpeg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779708&di=0dd9701325e1cfe12b8431ab84801988&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201408%2F27%2F20140827090335_wRrcL.png",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779708&di=22c82b7d313ec4e9f1135d706090ee3c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F013e5756ea76426ac72558857958a5.jpg%401280w_1l_2o_100sh.jpg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779708&di=160bb26cb0ee26c2d9561ac28c7ad4c5&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201407%2F23%2F20140723001831_8QZyP.jpeg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521540779708&di=74d693206d188ca669d124fc87f92ef2&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01591c55447e660000019ae9039a22.jpg",
                                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521804853610&di=9380e16e745c0714be589e16cccfac95&imgtype=0&src=http%3A%2F%2Fpic13.nipic.com%2F20110319%2F6682414_092248180187_2.jpg",
                                 @"http://wx4.sinaimg.cn/large/3d7c4647gy1fqyhu8lsq9j20rs55a7wk.jpg",
                                 ];
    }
    return _imageURLStringArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
