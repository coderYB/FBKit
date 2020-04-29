//
//  EDTAddressEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import EDTTable;
#import "EDTConfig.h"
@import EDTBean;
@import EDTBridge;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,EDTAddressEditActionType) {
    
    EDTAddressEditActionTypeArea,
    
    EDTAddressEditActionTypeCompleted
};

typedef void(^EDTAddressEditBlock)(EDTBaseViewController *from,EDTAddressEditActionType actionType, EDTAddressBean *_Nullable addressBean ,EDTAddressEditBean *_Nullable addressEditBean);

@interface EDTAddressEditTableViewCell : EDTBaseTableViewCell


@end

@interface EDTAddressEditViewController : EDTTableNoLoadingViewController

+ (instancetype)creatAddressEditWithAddressBean:(EDTAddressBean *_Nullable)addressBean andAddressEditBlock:(EDTAddressEditBlock) block ;

- (void)updateAddressEditArea:(EDTAddressEditBean *) addressEditBean;

@end

NS_ASSUME_NONNULL_END
