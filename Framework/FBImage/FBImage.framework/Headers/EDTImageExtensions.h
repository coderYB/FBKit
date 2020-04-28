//
//  FBImageCata.h
//  FBImage
//
//  Created by 王磊 on 2020/4/26.
//  Copyright © 2020 王磊. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FBCast)

+ (UIImage *)FBTransformToImageForView:(UIView *)view;

+ (UIImage *)FBTransformFromHexValue:(NSString *)hexValue;

+ (UIImage *)FBTransformFromAlphaHexValue:(NSString *)hexValue;

+ (UIImage *)FBTransformFromColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
