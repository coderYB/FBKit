//
//  FBShowType.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "FBSignConfig.h"

#if FBCONFIGURETYPEESTATE

#define FBProjectColor "#ba6e17"

#pragma mark --- 是否更新时启用

#define FBUPDATEVERSION 0

#pragma mark ---

#define FBCONTAINDRAWER 1

#define FBCONTAINERTAB 0

#define FBCONTAINERFORCELOGIN 1

// MARK: 登陆 导航透明色
#define FBLOGINNAVALPHA 1

// MARK: 个人中心 导航透明色
#define FBPROFILEALPHA 1

#pragma mark ---welcome

#define FBWelcomeOne 1

#pragma mark ---login

#define FBLoginOne 1

#pragma mark ---个人中心 1- 4 profile 5- 8 usercenter

#define FBMeOne 1

#pragma mark ---bannerType

#define FBCarouselOne 1

#pragma mark ---setting userinfo one hasplace two no place

#define FBUserInfoOne 1

#pragma mark --- name signtrue feedback

#define FBNameOne 1

#elif FBCONFIGURETYPETHERMAL

#define FBColor "#333333"

#pragma mark --- 是否更新时启用

#define FBUPDATEVERSION 0

#pragma mark ---

#define FBCONTAINDRAWER 0

#define FBCONTAINERTAB 1

// MARK: 登陆 导航透明色
#define FBLOGINNAVALPHA 0

// MARK: 个人中心 导航透明色
#define FBPROFILEALPHA 0

#pragma mark ---welcome

#define FBWelcomeOne 0

#define FBWelcomeTwo 1

#pragma mark ---login

#define FBLoginOne 0

#define FBLoginTwo 1

#pragma mark ---个人中心 1- 4 profile 5- 8 usercenter

#define FBMeOne 0

#define FBMeTwo 1

#pragma mark ---bannerType

#define FBCarouselOne 0

#define FBCarouselTwo 1

#pragma mark ---setting userinfo one hasplace two no place

#define FBUserInfoOne 0

#define FBUserInfoTwo 1

#pragma mark --- name signtrue feedback

#define FBNameOne 0

#define FBNameTwo 1

#endif


