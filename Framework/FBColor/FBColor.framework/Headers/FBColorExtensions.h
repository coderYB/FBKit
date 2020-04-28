//
//  UIColor+FB.h
//  FBColor
//
//  Created by 王磊 on 2020/4/25.
//  Copyright © 2020 王磊. All rights reserved.
//


@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FB)

+ (NSArray <NSNumber *>*)FB_transformByHexValue:(NSString *)hexValue;

+ (UIColor *)FB_transformToColorByHexValue:(NSString *)hexValue;

+ (UIColor *)FB_transformTo_AlphaColorByHexValue:(NSString *)hexValue;

@end

NS_ASSUME_NONNULL_END
