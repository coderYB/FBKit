//
//  FBTableView.h
//  FBTable
//
//  Created by 王磊 on 2020/4/23.
//  Copyright © 2020 王磊. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface FBEmptyView : UIView

- (void)emptyShow;

- (void)emptyHidden;

@end


typedef NS_ENUM(NSInteger ,FBBottomLineType) {
    
    FBBottomLineTypeNormal NS_SWIFT_NAME(normal),
    
    FBBottomLineTypeNone NS_SWIFT_NAME(none) ,
    
    FBBottomLineTypeCustom NS_SWIFT_NAME(custom)
};

@interface FBBaseTableViewCell : UITableViewCell

@property (nonatomic ,strong ,readonly) UIImageView *bottomView;

@property (nonatomic ,assign) FBBottomLineType bottomLineType;

- (void)commitInit;
@end

@interface FBTableHeaderView : UIView

- (void)commitInit;

@end
NS_ASSUME_NONNULL_END
