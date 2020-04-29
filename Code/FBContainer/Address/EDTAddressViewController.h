//
//  EDTAddressViewController.h
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

typedef void(^EDTAddressBlock)(EDTAddressActionType actionType,EDTAddressBean *_Nullable address ,NSIndexPath *_Nullable ip ,EDTBaseViewController *from);

@interface EDTAddressViewController : EDTTableLoadingViewController

+ (instancetype)createAddressWithBlock:(EDTAddressBlock) addressBlock;

- (void)updateAddress:(EDTAddressBean *)addressBean andIp:(NSIndexPath *)ip;

- (void)insertAddress:(EDTAddressBean *)addressBean;

@end

NS_ASSUME_NONNULL_END
