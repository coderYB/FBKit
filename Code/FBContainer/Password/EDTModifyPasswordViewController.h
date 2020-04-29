//
//  EDTModifyPasswordViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTConfig.h"
@import EDTBridge;
@import EDTTransition;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , EDTModifyPasswordActionType) {
    
     EDTModifyPasswordActionTypeBack,
    
     EDTModifyPasswordActionTypeModify
};

typedef void(^EDTModifyPasswordBlock)(EDTBaseViewController *password ,EDTModifyPasswordActionType actionType);
@interface EDTModifyPasswordViewController : EDTTViewController

+ (instancetype)createPasswordWithBlock:(EDTModifyPasswordBlock )block;
@end

NS_ASSUME_NONNULL_END
