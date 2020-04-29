//
//  FBCollectionViewComponent.h
//  FBCollection
//
//  Created by 王磊 on 2020/4/23.
//  Copyright © 2020 王磊. All rights reserved.
//

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface FBBaseCollectionViewCell : UICollectionViewCell

- (void)commitInit;

@end

@interface FBCollectionFooterView : UICollectionReusableView

@end

@interface FBCollectionHeaderView : UICollectionReusableView

@end

@interface FBCollectionEmptyView : UIView

- (void)emptyShow;

- (void)emptyHidden;

@end

NS_ASSUME_NONNULL_END
