//
//  FBImage.h
//  FBImage
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBImage.
FOUNDATION_EXPORT double FBImageVersionNumber;

//! Project version string for FBImage.
FOUNDATION_EXPORT const unsigned char FBImageVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBImage/PublicHeader.h>


#import <FBImage/EDTImageExtensions.h>

#define FB_IMAGE_CREATE(name) [UIImage imageNamed: name]
