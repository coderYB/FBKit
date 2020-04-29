//
//  FBLoginViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//


#import "FBConfig.h"
@import FBBridge;
@import FBTransition;
NS_ASSUME_NONNULL_BEGIN

typedef void(^FBLoginBlock)(FBLoginActionType actionType ,FBBaseViewController *from);

@interface FBLoginViewController : FBTViewController

+ (instancetype)createLoginWithBlock:(FBLoginBlock)block;

@end

NS_ASSUME_NONNULL_END
