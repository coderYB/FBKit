//
//  FBSwiftLoginViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBConfig.h"
@import FBBridge;
@import FBTransition;

NS_ASSUME_NONNULL_BEGIN
typedef void(^FBSwiftLoginBlock)(FBSwiftLoginActionType actionType ,FBBaseViewController *from);
@interface FBSwiftLoginViewController : FBTViewController

+ (instancetype)createSwiftLoginWithBlock:(FBSwiftLoginBlock) block;
@end

NS_ASSUME_NONNULL_END
