//
//  ViewController.m
//  LNPhotoBrower-master
//
//  Created by 童玉龙 on 2018/3/14.
//  Copyright © 2018年 lengain. All rights reserved.
//

#import "LNViewController.h"

@interface LNViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"LNPhotoBrower";
    self.dataSource = @[@{@"title":@"本地图片浏览",
                          @"class":@"LNLocalImageViewController",
                          },
                        @{@"title":@"网络图片浏览(push)",
                          @"class":@"LNRemoteNetPushStyleViewController",
                          },
                        @{@"title":@"网络图片浏览(zoom)",
                          @"class":@"LNRemoteNetZoomStyleViewController",
                          }
                        ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSDictionary *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = self.dataSource[indexPath.row];
    UIViewController *target = [[NSClassFromString(item[@"class"]) alloc] init];
    target.title = item[@"title"];
    [self.navigationController pushViewController:target animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
