//
//  FBCommon.h
//  FBCommon
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBCommon.
FOUNDATION_EXPORT double FBCommonVersionNumber;

//! Project version string for FBCommon.
FOUNDATION_EXPORT const unsigned char FBCommonVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBCommon/PublicHeader.h>

#define FB_SCREEN [UIScreen mainScreen]

#define FB_SCREEN_BOUNDS [UIScreen mainScreen].bounds

#define FB_SCREEN_SIZE FB_SCREEN_BOUNDS.size

#define FB_SCREEN_WIDTH FB_SCREEN_SIZE.width

#define FB_SCREEN_HEIGHT FB_SCREEN_SIZE.height

#define FB_ISIPHONEX_UP (FB_SCREEN_HEIGHT >= 812)

#define FB_STATUSBAR_HEIGHT (FB_ISIPHONEX_UP ? 44 : 20)

#define FB_TOPLAYOUTGUARD (FB_STATUSBAR_HEIGHT + 44)

#define FB_TABBAR_HEIGHT (FB_ISIPHONEX_UP ? 83 : 49)

#define FB_SCREEN [UIScreen mainScreen]

#define FB_VIEWCONTROLLER_HEIGHT CGRectGetHeight(self.view.bounds)

#define FB_VIEWCONTROLLER_WIDTH CGRectGetWidth(self.view.bounds)

#define FB_VIEW_HEIGHT CGRectGetHeight(self.bounds)

#define FB_VIEW_WIDTH CGRectGetWidth(self.bounds)

#define FB_DEVICE [UIDevice currentDevice]

#define FB_DEVICE_NAME FB_DEVICE.name

#define FB_DEVICEOS FB_DEVICE.systemName

#define FB_DEVICEID FB_DEVICE.identifierForVendor.UUIDString

#define FB_IMAGEVIEW_NEW [UIImageView new]

#define FB_LABEL_NEW [UILabel new]

#define FB_VIEW_NEW [UIView new]

#define FB_BUTTON_NEW [UIButton buttonWithType:UIButtonTypeCustom]

#define FB_SYSTEM_FONT(fontSize) [UIFont systemFontOfSize:fontSize]

#define FB_BOLD_FONT(fontSize) [UIFont boldSystemFontOfSize:fontSize]
