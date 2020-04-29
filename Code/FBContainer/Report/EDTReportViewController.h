//
//  EDTReportViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTConfig.h"

@import EDTTable;
@import EDTBridge;
NS_ASSUME_NONNULL_BEGIN

@interface EDTReportTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTReportBean * reportBean;

@end

typedef void(^EDTReportBlock)(EDTBaseViewController *from);
@interface EDTReportViewController : EDTTableNoLoadingViewController

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode andBlock:(EDTReportBlock) block;

@end


NS_ASSUME_NONNULL_END
