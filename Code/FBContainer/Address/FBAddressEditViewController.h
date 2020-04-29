//
//  FBAddressEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import FBTable;
#import "FBConfig.h"
@import FBBean;
@import FBBridge;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,FBAddressEditActionType) {
    
    FBAddressEditActionTypeArea,
    
    FBAddressEditActionTypeCompleted
};

typedef void(^FBAddressEditBlock)(FBBaseViewController *from,FBAddressEditActionType actionType, FBAddressBean *_Nullable addressBean ,FBAddressEditBean *_Nullable addressEditBean);

@interface FBAddressEditTableViewCell : FBBaseTableViewCell


@end

@interface FBAddressEditViewController : FBTableNoLoadingViewController

+ (instancetype)creatAddressEditWithAddressBean:(FBAddressBean *_Nullable)addressBean andAddressEditBlock:(FBAddressEditBlock) block ;

- (void)updateAddressEditArea:(FBAddressEditBean *) addressEditBean;

@end

NS_ASSUME_NONNULL_END
