//
//  FBColor.h
//  FBColor
//
//  Created by 王磊 on 2020/4/25.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBColor.
FOUNDATION_EXPORT double FBColorVersionNumber;

//! Project version string for FBColor.
FOUNDATION_EXPORT const unsigned char FBColorVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBColor/PublicHeader.h>

#import <FBColor/FBColorExtensions.h>

#define FB_COLOR_CREATE(hexValue) [UIColor FB_transformToColorByHexValue:hexValue]

#define FB_ALPHA_COLOR_CREATE(hexValue) [UIColor FB_transformTo_AlphaColorByHexValue:hexValue]
