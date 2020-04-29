//
//  FBFeedBackViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "FBConfig.h"
@import FBBridge;
@import FBTransition;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FBFeedBackBlock)(FBBaseViewController *from);

@interface FBFeedBackViewController : FBTViewController

+ (instancetype)createFeedBackWithBlock:(FBFeedBackBlock)block;

@end

NS_ASSUME_NONNULL_END
