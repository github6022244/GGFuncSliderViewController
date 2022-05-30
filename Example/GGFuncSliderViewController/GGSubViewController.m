//
//  GGSubViewController.m
//  GGFuncSliderViewController_Example
//
//  Created by GG on 2022/5/27.
//  Copyright © 2022 1563084860@qq.com. All rights reserved.
//

#import "GGSubViewController.h"
#import <QMUIKit/UIColor+QMUI.h>
#import <MJRefresh/MJRefresh.h>
#import <QMUIKit/QMUICommonDefines.h>
#import <QMUIKit/QMUIConfigurationMacros.h>
#import <QMUIKit/UIView+QMUI.h>

#import "GGViewController.h"

@interface GGSubViewController ()

@end

@implementation GGSubViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark ------------------------- Net -------------------------
#pragma mark --- 刷新方法
/// @param isHeaderRefresh 是否是 header 下拉刷新
- (void)tableViewRefreshWithIsHeaderRefresh:(BOOL)isHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    
    // 模拟耗时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (isHeaderRefresh) {
            // 下拉刷新
            [weakSelf controlMainControllerHeaderEndRefresh];
        } else {
            // footer 上拉加载
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    });
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    self.view.backgroundColor = UIColorWhite;
}

- (void)initTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)configTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = UIColorMakeWithHex(@"EBEBEB");
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf tableViewRefreshWithIsHeaderRefresh:NO];
    }];
}

#pragma mark ------------------------- Delegate -------------------------
- (CGRect)layoutConfigTableViewFrame {
    return self.view.bounds;
}

- (void)UIBaseFuncSliderControllerHeaderRefresh {
    if (self.isShowing) {
        [self tableViewRefreshWithIsHeaderRefresh:YES];
    }
}

- (void)listDidAppear {
//    if (self.isShowing && <#是不是空数据#>) {
//        [self tableViewRefreshWithIsHeaderRefresh:YES];
//    }
    if (self.isShowing) {
        [self tableViewRefreshWithIsHeaderRefresh:YES];
    }
}

#pragma mark --- TableView Delegate 、 DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"IndexPath : %ld %ld", (long)indexPath.section, (long)indexPath.row];
    
    cell.backgroundColor = [UIColor qmui_randomColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GGViewController *vc = [[GGViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

