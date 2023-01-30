//
//  GGViewController.m
//  GGFuncSliderViewController_Example
//
//  Created by GG on 2022/5/27.
//  Copyright © 2022 1563084860@qq.com. All rights reserved.
//

#import "GGViewController.h"
#import "GGSubViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <QMUIKit.h>
#import <YYText.h>

@interface GGViewController ()

@property (nonatomic, strong) NSArray *subControllersArray;// 存储子控制器的数组

@property (nonatomic, strong) UIView *headerView;// header view

@property (nonatomic, strong) QMUINavigationButton *navButton;

@end

@implementation GGViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 为了设置导航栏标题颜色、导航栏颜色 不会被下个控制器影响
    [self mainScrollDidScroll:self.pagerView.mainTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
    
    [self setupNavigationItems];
    
    [self setUpUI];
}

#pragma mark ------------------------- Net -------------------------
#pragma mark --- header 刷新
- (void)headerRefresh {
    GGSubViewController *subVC = _subControllersArray[self.categoryView.selectedIndex];
    [subVC UIBaseFuncSliderControllerHeaderRefresh];
}

#pragma mark ------------------------- Config -------------------------
- (void)config {
    NSMutableArray *marr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 2; i++) {
        GGSubViewController *vc = [[GGSubViewController alloc] init];
        vc.delegate = self;
        
        [marr addObject:vc];
    }
    
    _subControllersArray = marr;
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpUI {
    // 设置 pagerView 距离上方悬停距离
    self.pagerView.pinSectionHeaderVerticalOffset = NavigationContentTop;
}

- (void)setupNavigationItems {
//    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"主控制器";
    
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: UIColorClear,
    };
    
    QMUINavigationButton *navButton = [[QMUINavigationButton alloc] initWithType:QMUINavigationButtonTypeNormal];
    _navButton = navButton;
    [navButton setTitle:@"测试" forState:UIControlStateNormal];
//    navButton.adjustsImageTintColorAutomatically = NO;
    [navButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
    
//    /// 注意：如果导航栏的 tintColor 随滑动改变
//    /// UIBarButtonItem 的 tintColor 随父视图改变，所以需要在 tintColorDidChange 里重新指定文字颜色，否则其颜色随父视图 tintColor 改变，就会看不到文字了(与导航栏背景色一致了)
//    __weak __typeof(self)weakSelf = self;
//    navButton.qmui_tintColorDidChangeBlock = ^(__kindof UIView * _Nonnull view) {
//        weakSelf.navButton.tintColor = UIColorWhite;
//    };
    
    UIBarButtonItem *item = [UIBarButtonItem qmui_itemWithButton:navButton target:self action:nil];
    // 勿用 self.navigationController.navigationItem.xxx ，不起作用
//    self.navigationController.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark --- 配置 Pager View
// 自己配置 pagerView ，有默认实现
- (JXPagerView *)preferredPagingView {
    JXPagerView *view = [super preferredPagingView];
    view.mainTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#F7F7F7"];
    return view;
}

#pragma mark --- 配置 CategoryView
// 自己配置 categoryView
- (void)configCategorySliderStyle {
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15 * 2, [self categorySliderHeight])];
    cover.layer.cornerRadius = 6.0;
    cover.backgroundColor = UIColorWhite;
    cover.userInteractionEnabled = YES;
    
    [self.categoryView addSubview:cover];
    [self.categoryView sendSubviewToBack:cover];
    self.categoryView.backgroundColor = UIColorClear;
    
    self.categoryView.contentEdgeInsetLeft = 15.0;
    self.categoryView.contentEdgeInsetRight = 15.0;
    self.categoryView.cellWidth = (SCREEN_WIDTH - cover.qmui_left * 2) / [self categorySliderTitles].count;
}

- (CGRect)configPagerViewFrame {
    CGRect baseRect = [super configPagerViewFrame];
    
    baseRect = CGRectSetY(baseRect, - NavigationContentTop);
    baseRect = CGRectSetHeight(baseRect, SCREEN_HEIGHT);
    
    return baseRect;
}

// 分类栏标题数组
- (NSArray *)categorySliderTitles {
    return @[@"子控制器-1", @"子控制器-2"];
}

// 分类栏高度
- (CGFloat)categorySliderHeight {
    return 50.f;
}

#pragma mark --- 配置 Header
// 下拉刷新控件
- (void)configRefreshHeader {
    __weak typeof(self) ws = self;
    self.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws headerRefresh];
    }];
}

// 返回 headerView
- (UIView *)configHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.0)];
    
    header.backgroundColor = [UIColor qmui_randomColor];
    
    UILabel *label = [[UILabel alloc] qmui_initWithSize:header.mj_size];
    [header addSubview:label];
    label.text = @"Header View";
    label.font = UIFontBoldMake(20.f);
    label.textAlignment = NSTextAlignmentCenter;
    
    self.headerView = header;
    
    return header;
}

#pragma mark --- 设置每一页的控制器
/// 每一页的控制器
- (UIBaseFuncSliderSubController *)configPagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    return _subControllersArray[index];
}

#pragma mark --- 导航栏配置
// 是否开启自动导航栏渐变
- (BOOL)autoAlphaNavigationBar {
    return YES;
}
// 在多少滑动距离内计算导航栏转换颜色
- (CGFloat)autoAlphaNavigationBarScrollOffset {
    return self.headerView.qmui_height - NavigationContentTop;
}

// 导航栏初始颜色/滑动动画最终颜色
- (NSArray<UIColor *> *)navigationBarDefaultAndFullColor {
    return @[
        UIColorClear,
        UIColorBlue,
    ];
}

#pragma mark --- 子控制器要求 开始/停止刷新 回调
// 主控制器开始刷新
- (void)mainControllerBeginRefresh {
    if (!self.pagerView.mainTableView.mj_header.isRefreshing) {
        [self.pagerView.mainTableView.mj_header beginRefreshing];
    }
}
// 主控制器停止刷新
- (void)mainControllerEndRefresh {
    [self.pagerView.mainTableView.mj_header endRefreshing];
}
// 主控制器是否在刷新
- (BOOL)mainControllerIsRefreshing {
    return self.pagerView.mainTableView.mj_header.isRefreshing;
}

#pragma mark --- 其他
// self.pagerView.mainTableView 滑动回调
- (void)mainScrollDidScroll:(UIScrollView *)scrollView {
    CGFloat thresholdDistance = [self autoAlphaNavigationBarScrollOffset];
    CGFloat percent = scrollView.contentOffset.y / thresholdDistance;
    percent = MAX(0, MIN(1, percent));
    
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColorBlack colorWithAlphaComponent:percent],
    };
}

#pragma mark ------------------------- set / get -------------------------
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
