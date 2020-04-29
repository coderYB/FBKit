//
//  EDTShowType.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTSignConfig.h"

#if EDTCONFIGURETYPESWIMMING

#define EDTProjectColor "#4b95fe"

#pragma mark --- 是否更新时启用

#define EDTUPDATEVERSION 0

#pragma mark ---

#define EDTCONTAINDRAWER 1

#define EDTCONTAINERTAB 1

// MARK: 登陆 导航透明色
#define EDTLOGINNAVALPHA 1

// MARK: 个人中心 导航透明色
#define EDTPROFILEALPHA 0

#pragma mark ---welcome

#define EDTWelcomeOne 1

#pragma mark ---login

#define EDTLoginOne 1

#pragma mark ---个人中心 1- 4 profile 5- 8 usercenter

#define EDTMeOne 1

#pragma mark ---bannerType

#define EDTCarouselOne 1

#pragma mark ---setting userinfo one hasplace two no place

#define EDTUserInfoOne 1

#pragma mark --- name signtrue feedback

#define EDTNameOne 1

#elif EDTCONFIGURETYPETHERMAL

#define EDTColor "#333333"

#pragma mark --- 是否更新时启用

#define EDTUPDATEVERSION 0

#pragma mark ---

#define EDTCONTAINDRAWER 0

#define EDTCONTAINERTAB 1

// MARK: 登陆 导航透明色
#define EDTLOGINNAVALPHA 0

// MARK: 个人中心 导航透明色
#define EDTPROFILEALPHA 0

#pragma mark ---welcome

#define EDTWelcomeOne 0

#define EDTWelcomeTwo 1

#pragma mark ---login

#define EDTLoginOne 0

#define EDTLoginTwo 1

#pragma mark ---个人中心 1- 4 profile 5- 8 usercenter

#define EDTMeOne 0

#define EDTMeTwo 1

#pragma mark ---bannerType

#define EDTCarouselOne 0

#define EDTCarouselTwo 1

#pragma mark ---setting userinfo one hasplace two no place

#define EDTUserInfoOne 0

#define EDTUserInfoTwo 1

#pragma mark --- name signtrue feedback

#define EDTNameOne 0

#define EDTNameTwo 1

#endif


