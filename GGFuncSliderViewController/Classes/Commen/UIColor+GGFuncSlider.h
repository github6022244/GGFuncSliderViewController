//
//  UIColor+GGFuncSlider.h
//  GGFuncSliderViewController
//
//  Created by GG on 2024/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GGFuncSlider)

/**
 *  获取当前 UIColor 对象里的红色色值
 *
 *  @return 红色通道的色值，值范围为0.0-1.0
 */
@property(nonatomic, assign, readonly) CGFloat gg_red;

/**
 *  获取当前 UIColor 对象里的绿色色值
 *
 *  @return 绿色通道的色值，值范围为0.0-1.0
 */
@property(nonatomic, assign, readonly) CGFloat gg_green;

/**
 *  获取当前 UIColor 对象里的蓝色色值
 *
 *  @return 蓝色通道的色值，值范围为0.0-1.0
 */
@property(nonatomic, assign, readonly) CGFloat gg_blue;

/**
 *  获取当前 UIColor 对象里的透明色值
 *
 *  @return 透明通道的色值，值范围为0.0-1.0
 */
@property(nonatomic, assign, readonly) CGFloat gg_alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 *  将自身变化到某个目标颜色，可通过参数progress控制变化的程度，最终得到一个纯色
 *  @param toColor 目标颜色
 *  @param progress 变化程度，取值范围0.0f~1.0f
 */
- (UIColor *)transitionToColor:(nullable UIColor *)toColor progress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
