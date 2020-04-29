//
//  FBShare.h
//  FBShare
//
//  Created by 王磊 on 2020/4/25.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBShare.
FOUNDATION_EXPORT double FBShareVersionNumber;

//! Project version string for FBShare.
FOUNDATION_EXPORT const unsigned char FBShareVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBShare/PublicHeader.h>

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(FBShare)
@interface FBShare : NSObject

+ (void)FBShareDownloadWithFrom:(UIViewController * _Nonnull)from
                      andAppleId:(NSString * _Nonnull)appleId
                    andShareIcon:(NSString * _Nonnull)shareIcon;


+ (void)FBShareWithFrom:(UIViewController * _Nonnull)from
            andUrlString:(NSString * _Nonnull)urlString
            andShareIcon:(NSString * _Nonnull)shareIcon;
@end

NS_ASSUME_NONNULL_END
