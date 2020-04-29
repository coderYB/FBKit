//
//  FBCarouselViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "FBConfig.h"
@import FBCollection;

NS_ASSUME_NONNULL_BEGIN

@interface FBCarouselViewController : FBCollectionNoLoadingViewController

+ (instancetype)createCarousel;

@end

NS_ASSUME_NONNULL_END
