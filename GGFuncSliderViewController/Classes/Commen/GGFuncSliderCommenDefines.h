//
//  GGFuncSliderCommenDefines.h
//  GGFuncSliderViewController
//
//  Created by GG on 2024/6/14.
//

#import <Foundation/Foundation.h>

/// 字体相关的宏，用于快速创建一个字体对象，更多创建宏可查看 UIFont+QMUI.h
#define GGFuncSliderUIFontMake(size) [UIFont systemFontOfSize:size]
#define GGFuncSliderUIFontItalicMake(size) [UIFont italicSystemFontOfSize:size] /// 斜体只对数字和字母有效，中文无效
#define GGFuncSliderUIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#define GGFuncSliderUIFontBoldWithFont(_font) [UIFont boldSystemFontOfSize:_font.pointSize]
