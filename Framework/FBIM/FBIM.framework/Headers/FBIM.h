//
//  FBIM.h
//  FBIM
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBIM.
FOUNDATION_EXPORT double FBIMVersionNumber;

//! Project version string for FBIM.
FOUNDATION_EXPORT const unsigned char FBIMVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBIM/PublicHeader.h>

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FBIM)
@interface FBIM : NSObject

+ (void)initWithAppkey:(NSString * _Nonnull)appkey andAppSecret:(NSString * _Nonnull)appSecret;

+ (void)connetWithUserId:(NSString * _Nonnull)userId
                 andName:(NSString * _Nonnull)name
              andHeadImg:(NSString * _Nonnull)headImg
          andFetchUserId:( void (^)(NSString * _Nonnull userId))fetchUserId
              andFailure:( void (^)(NSError * _Nonnull error))failure;

+ (void)refreshWithUserId:(NSString * _Nonnull)userId
                  andName:(NSString * _Nonnull)name
               andHeadImg:(NSString * _Nonnull)headImg
           andFetchUserId:( void (^)(NSString * _Nonnull userId))fetchUserId
               andFailure:( void (^)(NSError * _Nonnull error))failure;

+ (void)fetchUserInfoWithUserId:(NSString * _Nonnull)userId
               andFetchUserInfo:( void (^)(id _Nullable userInfo))fetchUserInfo
                     andFailure:( void (^)(NSError * _Nonnull error))failure;

+ (void)logout;

@end

NS_ASSUME_NONNULL_END

#import <FBIM/FBConversationListViewController.h>

#import <FBIM/FBConversationViewController.h>
