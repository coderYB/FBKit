//
//  FBString.h
//  FBString
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBString.
FOUNDATION_EXPORT double FBStringVersionNumber;

//! Project version string for FBString.
FOUNDATION_EXPORT const unsigned char FBStringVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBString/PublicHeader.h>

#import <FBString/FBStringExtensions.h>

#define FB_COLOR_FORMAT_STRING(arg1,arg2) [NSString stringWithFormat:@"%@%@",arg1,arg2]
