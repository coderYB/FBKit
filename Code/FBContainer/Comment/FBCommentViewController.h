//
//  FBCommentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <FBTable/FBTable.h>
@import FBBean;
#import "FBConfig.h"
NS_ASSUME_NONNULL_BEGIN

@class FBCommentViewController;

typedef NS_ENUM(NSInteger ,FBCommentActionType) {
    
    FBCommentActionTypeUnLogin,
    
    FBCommentActionTypeComment,
    
    FBCommentActionTypeReport
    
};

typedef void(^FBCommentBlock)(FBCommentViewController *from ,FBCommentActionType type ,FBCircleBean *circleBean);

@protocol FBCommentTableViewCellDelegate <NSObject>

- (void)onMoreItemClick:(FBCommentBean *)comment;

@end

@interface FBCommentTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBCommentBean *comment;

@property (nonatomic ,weak) id <FBCommentTableViewCellDelegate>mDelegate;

@end

@interface FBCommentTotalTableViewCell : FBCommentTableViewCell


@end

@interface FBCommentRectangleTableViewCell : FBCommentTableViewCell

@end

@interface FBCommentNoMoreTableViewCell : FBCommentTableViewCell

@end

@interface FBCommentFailFBableViewCell : FBCommentTableViewCell

@end

@interface FBCommentEmptyTableViewCell : FBCommentTableViewCell

@end

@interface FBCommentContentTableViewCell : FBCommentTableViewCell


@end

@interface FBCommentViewController : FBTableLoadingViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andCircleBean:(FBCircleBean *)circleBean andOp:(FBCommentBlock) block;

@property (nonatomic ,strong ,readonly) UIView *bottomBar;

@end

NS_ASSUME_NONNULL_END
