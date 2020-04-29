//
//  EDTRegViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTConfig.h"
@import EDTBridge;
@import EDTTransition;

NS_ASSUME_NONNULL_BEGIN
typedef void(^EDTRegBlock)(EDTRegActionType actionType ,EDTBaseViewController *from);
@interface EDTRegViewController : EDTTViewController

+ (instancetype)createRegWithBlock:(EDTRegBlock) block;
@end

NS_ASSUME_NONNULL_END
