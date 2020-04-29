//
//  EDTFeedBackViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTConfig.h"
@import EDTBridge;
@import EDTTransition;

NS_ASSUME_NONNULL_BEGIN

typedef void(^EDTFeedBackBlock)(EDTBaseViewController *from);

@interface EDTFeedBackViewController : EDTTViewController

+ (instancetype)createFeedBackWithBlock:(EDTFeedBackBlock)block;

@end

NS_ASSUME_NONNULL_END
