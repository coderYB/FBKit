//
//  EDTFindPasswordViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTConfig.h"
@import EDTBridge;
@import EDTTransition;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger , EDTFindPasswordActionType) {
    
     EDTFindPasswordActionTypeBack,
    
     EDTFindPasswordActionTypeFind
};

typedef void(^EDTFindPassworBlock)(EDTBaseViewController *from ,EDTFindPasswordActionType actionType);
@interface EDTFindPasswordViewController : EDTTViewController

+ (instancetype)createPasswordWithBlock:(EDTFindPassworBlock )block;

@end

NS_ASSUME_NONNULL_END
