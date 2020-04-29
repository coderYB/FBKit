//
//  EDTBannerViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTConfig.h"
@import EDTCollection;

NS_ASSUME_NONNULL_BEGIN

@interface EDTBannerViewController : EDTCollectionNoLoadingViewController

+ (instancetype)createBannerWithBanners:(NSArray <NSDictionary *>*)banners;

@end

NS_ASSUME_NONNULL_END
