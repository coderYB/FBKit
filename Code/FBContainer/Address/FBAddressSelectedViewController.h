//
//  FBAddressSelectedViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//
#import "FBConfig.h"
@import FBTable;
@import FBBean;
@import FBBridge;
NS_ASSUME_NONNULL_BEGIN

typedef void(^FBAddressSelectedBlock)(FBAddressActionType actionType,FBAddressBean *_Nullable address ,NSIndexPath *_Nullable ip ,FBBaseViewController *from);

@interface FBAddressSelectedViewController : FBTableLoadingViewController

+ (instancetype)createAddressSelectedWithBlock:(FBAddressSelectedBlock) addressBlock;

- (void)updateAddress:(FBAddressBean *)addressBean andIp:(NSIndexPath *)ip;

- (void)insertAddress:(FBAddressBean *)addressBean;

@end

NS_ASSUME_NONNULL_END
