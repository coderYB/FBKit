//
//  FBBannerViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "FBConfig.h"
@import FBCollection;

NS_ASSUME_NONNULL_BEGIN

@interface FBBannerViewController : FBCollectionNoLoadingViewController

+ (instancetype)createBannerWithBanners:(NSArray <NSDictionary *>*)banners;

@end

NS_ASSUME_NONNULL_END
