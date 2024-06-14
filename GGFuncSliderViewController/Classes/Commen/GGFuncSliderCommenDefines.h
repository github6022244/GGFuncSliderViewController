//
//  GGFuncSliderCommenDefines.h
//  GGFuncSliderViewController
//
//  Created by GG on 2024/6/14.
//

#import <Foundation/Foundation.h>

/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)
#define GGFuncSliderStatusBarHeight (UIApplication.sharedApplication.statusBarHidden ? 0 : UIApplication.sharedApplication.statusBarFrame.size.height)

/// navigationBar 的静态高度
#define GGFuncSliderNavigationBarHeight (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 50 : 44)

/// 代表(导航栏+状态栏)，这里用于获取其高度
/// @warn 如果是用于 viewController，请使用 UIViewController(QMUI) qmui_navigationBarMaxYInViewCoordinator 代替
#define GGFuncSliderNavigationContentTop (GGFuncSliderStatusBarHeight + GGFuncSliderNavigationBarHeight)

/// 用户界面横屏了才会返回YES
#define GGFuncSliderIS_LANDSCAPE UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)

#define GGFuncSliderSCREEN_WIDTH GGFuncSliderApplicationSize().width

CG_INLINE CGSize
GGFuncSliderApplicationSize() {
    /// applicationFrame 在 iPad 下返回的 size 要比 window 实际的 size 小，这个差值体现在 origin 上，所以用 origin + size 修正得到正确的大小。
//    BeginIgnoreDeprecatedWarning
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
//    EndIgnoreDeprecatedWarning
    CGSize applicationSize = CGSizeMake(applicationFrame.size.width + applicationFrame.origin.x, applicationFrame.size.height + applicationFrame.origin.y);
    if (CGSizeEqualToSize(applicationSize, CGSizeZero)) {
        // 实测 MacCatalystApp 通过 [UIScreen mainScreen].applicationFrame 拿不到大小，这里做一下保护
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        if (window) {
            applicationSize = window.bounds.size;
        } else {
            applicationSize = UIWindow.new.bounds.size;
        }
    }
    return applicationSize;
}

/// 字体相关的宏，用于快速创建一个字体对象，更多创建宏可查看 UIFont+QMUI.h
#define GGFuncSliderUIFontMake(size) [UIFont systemFontOfSize:size]
#define GGFuncSliderUIFontItalicMake(size) [UIFont italicSystemFontOfSize:size] /// 斜体只对数字和字母有效，中文无效
#define GGFuncSliderUIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#define GGFuncSliderUIFontBoldWithFont(_font) [UIFont boldSystemFontOfSize:_font.pointSize]
