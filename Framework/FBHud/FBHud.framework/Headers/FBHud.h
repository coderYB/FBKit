//
//  FBHud.h
//  FBHud
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBHud.
FOUNDATION_EXPORT double FBHudVersionNumber;

//! Project version string for FBHud.
FOUNDATION_EXPORT const unsigned char FBHudVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBHud/PublicHeader.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FBHud)
@interface FBHud : NSObject

+ (void)configHud NS_SWIFT_NAME(configHud());

+ (void)showActivity NS_SWIFT_NAME(show());

+ (void)showInfo:(NSString *_Nonnull)msg;

+ (void)showWithStatus:(NSString * _Nullable)msg;

+ (void)pop NS_SWIFT_NAME(pop());

@end

NS_ASSUME_NONNULL_END
