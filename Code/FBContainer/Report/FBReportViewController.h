//
//  FBReportViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "FBConfig.h"

@import FBTable;
@import FBBridge;
NS_ASSUME_NONNULL_BEGIN

@interface FBReportTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBReportBean * reportBean;

@end

typedef void(^FBReportBlock)(FBBaseViewController *from);
@interface FBReportViewController : FBTableNoLoadingViewController

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode andBlock:(FBReportBlock) block;

@end


NS_ASSUME_NONNULL_END
