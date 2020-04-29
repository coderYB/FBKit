//
//  EDTAddressSelectedViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//
#import "EDTConfig.h"
@import EDTTable;
@import EDTBean;
@import EDTBridge;
NS_ASSUME_NONNULL_BEGIN

typedef void(^EDTAddressSelectedBlock)(EDTAddressActionType actionType,EDTAddressBean *_Nullable address ,NSIndexPath *_Nullable ip ,EDTBaseViewController *from);

@interface EDTAddressSelectedViewController : EDTTableLoadingViewController

+ (instancetype)createAddressSelectedWithBlock:(EDTAddressSelectedBlock) addressBlock;

- (void)updateAddress:(EDTAddressBean *)addressBean andIp:(NSIndexPath *)ip;

- (void)insertAddress:(EDTAddressBean *)addressBean;

@end

NS_ASSUME_NONNULL_END
