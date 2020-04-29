//
//  FBSignatureViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBConfig.h"
@import FBBridge;
@import FBTransition;

NS_ASSUME_NONNULL_BEGIN
typedef void(^FBSignatureBlock)(FBSignatureActionType actionType,FBBaseViewController *from);

@interface FBSignatureViewController : FBTViewController

+ (instancetype)createSignatureWithBlock:(FBSignatureBlock)block;

@end

NS_ASSUME_NONNULL_END
