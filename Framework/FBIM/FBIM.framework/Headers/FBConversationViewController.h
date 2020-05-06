//
//  FBConversationViewController.h
//  FBIM
//
//  Created by 王磊 on 2020/4/27.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBConversationViewController : RCConversationViewController

@property(nonatomic,strong,readonly) UIPercentDrivenInteractiveTransition *FBInteractivePopTransition;

@property (nonatomic ,assign) BOOL canPanResponse;

@end

NS_ASSUME_NONNULL_END
