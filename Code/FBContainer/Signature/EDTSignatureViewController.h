//
//  EDTSignatureViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTConfig.h"
@import EDTBridge;
@import EDTTransition;

NS_ASSUME_NONNULL_BEGIN
typedef void(^EDTSignatureBlock)(EDTSignatureActionType actionType,EDTBaseViewController *from);

@interface EDTSignatureViewController : EDTTViewController

+ (instancetype)createSignatureWithBlock:(EDTSignatureBlock)block;

@end

NS_ASSUME_NONNULL_END
