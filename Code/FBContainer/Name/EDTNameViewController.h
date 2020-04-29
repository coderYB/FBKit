//
//  EDTNameViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTConfig.h"
@import EDTBridge;
@import EDTTransition;

NS_ASSUME_NONNULL_BEGIN

typedef void(^EDTNameBlock)(EDTNameActionType actionType ,EDTBaseViewController *from);

@interface EDTNameViewController : EDTTViewController

+ (instancetype)createNickNameWithBlock:(EDTNameBlock)block;

@end

NS_ASSUME_NONNULL_END
