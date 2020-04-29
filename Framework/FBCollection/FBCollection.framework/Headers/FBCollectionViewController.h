//
//  FBCollectionViewController.h
//  FBCollection
//
//  Created by 王磊 on 2020/4/23.
//  Copyright © 2020 王磊. All rights reserved.
//
@import FBLoading;
@import MJRefresh;
#import "FBCollectionViewComponent.h"
NS_ASSUME_NONNULL_BEGIN

@interface FBCollectionNoLoadingViewController : FBTViewController

@property (nonatomic ,strong ,readonly) UICollectionView *collectionView;

- (UICollectionView *)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout;

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip ;

- (FBCollectionHeaderView *)configCollectionViewHeader:(id)data forIndexPath:(NSIndexPath *)ip;

- (FBCollectionFooterView *)configCollectionViewFooter:(id)data forIndexPath:(NSIndexPath *)ip;
@end

@interface FBCollectionLoadingViewController : FBLoadingViewController

@property (nonatomic ,strong ,readonly) UICollectionView *collectionView;

- (UICollectionView *)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout;

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip ;

- (void)collectionEmptyShow;

- (void)collectionEmptyHidden;

- (FBCollectionHeaderView *)configCollectionViewHeader:(id)data forIndexPath:(NSIndexPath *)ip;

- (FBCollectionFooterView *)configCollectionViewFooter:(id)data forIndexPath:(NSIndexPath *)ip;

@end

NS_ASSUME_NONNULL_END
