//
//  EDTCommentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <EDTTable/EDTTable.h>
@import EDTBean;
#import "EDTConfig.h"
NS_ASSUME_NONNULL_BEGIN

@class EDTCommentViewController;

typedef NS_ENUM(NSInteger ,EDTCommentActionType) {
    
    EDTCommentActionTypeUnLogin,
    
    EDTCommentActionTypeComment,
    
    EDTCommentActionTypeReport
    
};

typedef void(^EDTCommentBlock)(EDTCommentViewController *from ,EDTCommentActionType type ,EDTCircleBean *circleBean);

@protocol EDTCommentTableViewCellDelegate <NSObject>

- (void)onMoreItemClick:(EDTCommentBean *)comment;

@end

@interface EDTCommentTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTCommentBean *comment;

@property (nonatomic ,weak) id <EDTCommentTableViewCellDelegate>mDelegate;

@end

@interface EDTCommentTotalTableViewCell : EDTCommentTableViewCell


@end

@interface EDTCommentRectangleTableViewCell : EDTCommentTableViewCell

@end

@interface EDTCommentNoMoreTableViewCell : EDTCommentTableViewCell

@end

@interface EDTCommentFailedTableViewCell : EDTCommentTableViewCell

@end

@interface EDTCommentEmptyTableViewCell : EDTCommentTableViewCell

@end

@interface EDTCommentContentTableViewCell : EDTCommentTableViewCell


@end

@interface EDTCommentViewController : EDTTableLoadingViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andCircleBean:(EDTCircleBean *)circleBean andOp:(EDTCommentBlock) block;

@property (nonatomic ,strong ,readonly) UIView *bottomBar;

@end

NS_ASSUME_NONNULL_END
