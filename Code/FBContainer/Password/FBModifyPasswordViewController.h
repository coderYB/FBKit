//
//  FBModifyPasswordViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBConfig.h"
@import FBBridge;
@import FBTransition;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , FBModifyPasswordActionType) {
    
     FBModifyPasswordActionTypeBack,
    
     FBModifyPasswordActionTypeModify
};

typedef void(^FBModifyPasswordBlock)(FBBaseViewController *password ,FBModifyPasswordActionType actionType);
@interface FBModifyPasswordViewController : FBTViewController

+ (instancetype)createPasswordWithBlock:(FBModifyPasswordBlock )block;
@end

NS_ASSUME_NONNULL_END
