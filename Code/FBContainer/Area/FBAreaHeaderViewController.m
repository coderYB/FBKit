//
//  FBAreaHeaderViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "FBAreaHeaderViewController.h"
#import "FBAreaViewController.h"
@import FBColor;
@import FBCommon;
@interface FBAreaHeaderLayout: UICollectionViewFlowLayout

@end
#define FBArea_Width 80

#define FBArea_Height 44
@implementation FBAreaHeaderLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.itemSize = CGSizeMake(FBArea_Width, FBArea_Height);
}

@end

@interface FBAreaHeaderCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) FBAreaHeaderBean *headerBean;

@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation FBAreaHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#333333");
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
    
}
- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
}
- (void)setHeaderBean:(FBAreaHeaderBean *)headerBean {
    
    if (headerBean.areaBean) {
        
        self.titleLabel.text = headerBean.areaBean.name;
    } else {
        
        self.titleLabel.text = @"请选择";
    }
    
//    NSLog(@"%@ ==== %d ",headerBean.areaBean ,headerBean.isSelected);
    
    if (headerBean.isSelected) {
        
        self.titleLabel.textColor = FB_COLOR_CREATE(@FBProjectColor);
    } else {
        
        self.titleLabel.textColor = FB_COLOR_CREATE(@"#666666");
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
    
}

@end

@interface FBAreaHeaderViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource ,UIViewControllerTransitioningDelegate>

@property (nonatomic ,assign) NSInteger pid;

@property (nonatomic ,assign) NSInteger cid;

@property (nonatomic ,assign) NSInteger rid;

@property (nonatomic ,copy) FBAreaHeaderBlock block;

@property (nonatomic ,strong) UIPageViewController *pageViewController;

@property (nonatomic ,strong) FBAreaViewController *province;

@property (nonatomic ,strong) FBAreaViewController *city;

@property (nonatomic ,strong) FBAreaViewController *region;

@property (nonatomic ,strong) FBAreaHeaderBean *provinceHeader;

@property (nonatomic ,strong) FBAreaHeaderBean *cityHeader;

@property (nonatomic ,strong) FBAreaHeaderBean *regionHeader;

@property (nonatomic ,strong) FBAreaHeaderBridge *bridge;

@property (nonatomic ,assign) NSInteger currentIdx;

@property (nonatomic ,strong) NSMutableArray *viewControllers;

@property (nonatomic ,strong) FBAreaPresentAnimation *presentAnimation;

@property (nonatomic ,strong) FBAreaDismissAnimation *dismissAnimation;

@property (nonatomic ,strong) UIButton *cancleItem;

@end

@implementation FBAreaHeaderViewController

- (UIButton *)cancleItem {
    
    if (!_cancleItem) {
        
        _cancleItem = FB_BUTTON_NEW;
        
        [_cancleItem setTitle:@"取消" forState:UIControlStateNormal];
        
        [_cancleItem setTitle:@"取消" forState:UIControlStateHighlighted];
        
        _cancleItem.titleLabel.font = FB_SYSTEM_FONT(15);
        
        [_cancleItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
        
        [_cancleItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateHighlighted];
    }
    return _cancleItem;
}
+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger)rid andAreaHeaderBlock:( FBAreaHeaderBlock)block{
    
    return [[self alloc] initWithPid:pid andCid:cid andRid:rid andAreaHeaderBlock:block];
}
- (instancetype)initWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger)rid andAreaHeaderBlock:( FBAreaHeaderBlock)block{
    
    if (self = [super init]) {
        
        self.pid = pid;
        
        self.cid = cid;
        
        self.rid = rid;
        
        self.block = block;
    }
    return self;
}
- (FBAreaPresentAnimation *)presentAnimation {
    
    if (!_presentAnimation) {
        
        _presentAnimation = [FBAreaPresentAnimation new];
        
    }
    return _presentAnimation;
}
- (FBAreaDismissAnimation *)dismissAnimation {
    
    if (!_dismissAnimation) {
        
        _dismissAnimation = [FBAreaDismissAnimation new];
    }
    return _dismissAnimation;
}
- (FBAreaHeaderBean *)provinceHeader {
    
    if (!_provinceHeader) {
        
        _provinceHeader = [FBAreaHeaderBean new];
    }
    return _provinceHeader;
}

- (FBAreaHeaderBean *)cityHeader {
    
    if (!_cityHeader) {
        
        _cityHeader = [FBAreaHeaderBean new];
    }
    return _cityHeader;
}
- (FBAreaHeaderBean *)regionHeader {
    
    if (!_regionHeader) {
        
        _regionHeader = [FBAreaHeaderBean new];
    }
    return _regionHeader;
}
- (NSMutableArray *)viewControllers {
    
    if (!_viewControllers) {
        
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}
- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:@{}];
    }
    return _pageViewController;
}

- (void)addOwnSubViews {
    
    self.pageViewController.view.frame = CGRectMake(0, FBArea_Height + 1, self.view.bounds.size.width, self.view.bounds.size.height - FBArea_Height);
    
    [self addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    
    FBAreaHeaderLayout *layout = [FBAreaHeaderLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    [self.view addSubview:collectionView];
    
    collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, FBArea_Height);
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cancleItem];
    
    self.cancleItem.frame = CGRectMake(self.view.bounds.size.width - 40, 0, 40, FBArea_Height);

}
- (void)onCancleItemTap {
    
    [self dismissViewControllerAnimated:true completion:nil];
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBAreaHeaderCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.headerBean = data;
    
    return cell;
}

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    [self.pageViewController setViewControllers:@[self.viewControllers[ip.row]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
}
- (void)configOwnProperties {
    
    self.transitioningDelegate = self;
    
//    self.modalTransitionStyle
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[FBAreaHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.pageViewController.dataSource = self;
    
    self.pageViewController.delegate = self;
    
    self.bridge = [FBAreaHeaderBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    self.province = [FBAreaViewController createAreaWithType:FBAreaTypeProvince andAreaBlock:^(FBBaseViewController * _Nonnull from, FBAreaBean * _Nonnull selectedArea, FBAreaType type, BOOL hasNext) {
        
        if (weakSelf.viewControllers.count == 1) {
            
            [weakSelf.viewControllers addObject:weakSelf.city];
        }
        
        FBAreaViewController *city = weakSelf.viewControllers[1];
        
        [weakSelf.pageViewController setViewControllers:@[city] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
        
        [city updateAreas:selectedArea.areaId];
        
        weakSelf.provinceHeader.isSelected = true;
        
        weakSelf.provinceHeader.areaBean = selectedArea;
        
        weakSelf.cityHeader.isSelected = false;
        
        weakSelf.cityHeader.areaBean = nil;
        
        weakSelf.regionHeader.isSelected = false;
        
        weakSelf.regionHeader.areaBean = nil;
        
        if ([weakSelf.bridge fetchHeaderCount] == 1) {
            
            [weakSelf.bridge addheader:weakSelf.cityHeader];
        } else if ([weakSelf.bridge fetchHeaderCount] == 3) {
            
            [weakSelf.bridge removeHeader:weakSelf.regionHeader];
        }
        
        [weakSelf.collectionView reloadData];
    }];
    
    [self.viewControllers addObject:self.province];
    
    self.city = [FBAreaViewController createAreaWithType:FBAreaTypeCity andAreaBlock:^(FBBaseViewController * _Nonnull from, FBAreaBean * _Nonnull selectedArea, FBAreaType type, BOOL hasNext) {
        
        if (hasNext) {
            
            if (weakSelf.viewControllers.count == 2) {
                
                [weakSelf.viewControllers addObject:weakSelf.region];
            }
            
            FBAreaViewController *region = weakSelf.viewControllers.lastObject;
            
            [weakSelf.pageViewController setViewControllers:@[region] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
            
            [region updateAreas:selectedArea.areaId];
            
            weakSelf.cityHeader.isSelected = true;
            
            weakSelf.cityHeader.areaBean = selectedArea;
            
            weakSelf.regionHeader.isSelected = false;
            
            weakSelf.regionHeader.areaBean = nil;
            
            if ([weakSelf.bridge fetchHeaderCount] == 2) {
                
                [weakSelf.bridge addheader:weakSelf.regionHeader];
            }
            
            [weakSelf.collectionView reloadData];
        } else {
            
            weakSelf.cityHeader.isSelected = true;
            
            weakSelf.cityHeader.areaBean = selectedArea;
            
            weakSelf.block(weakSelf, weakSelf.provinceHeader.areaBean, weakSelf.cityHeader.areaBean, weakSelf.regionHeader.areaBean);
            
            [weakSelf dismissViewControllerAnimated:true completion:nil];
        }
        
    }];
    
    [self.viewControllers addObject:self.city];
    
    self.region = [FBAreaViewController createAreaWithType:FBAreaTypeRegion andAreaBlock:^(FBBaseViewController * _Nonnull from, FBAreaBean * _Nonnull selectedArea, FBAreaType type, BOOL hasNext) {
        
        weakSelf.regionHeader.isSelected = true;
        
        weakSelf.regionHeader.areaBean = selectedArea;
        
        weakSelf.block(weakSelf, weakSelf.provinceHeader.areaBean, weakSelf.cityHeader.areaBean, weakSelf.regionHeader.areaBean);
        
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
    
    [self.viewControllers addObject:self.region];
    
    [self.bridge createAreaHeader:self];
    
    [self.cancleItem addTarget:self action:@selector(onCancleItemTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self performSelector:@selector(onDelay) withObject:nil afterDelay:0.1];
    
}
- (void)onDelay {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.pid) {
        
        if (self.cid) {
            
            if (self.rid) {
                
                [self.pageViewController setViewControllers:@[self.province] direction:(UIPageViewControllerNavigationDirectionForward) animated:false completion:nil];
                
                [self.pageViewController setViewControllers:@[self.city] direction:(UIPageViewControllerNavigationDirectionForward) animated:false completion:nil];
                
                [self.city selectedArea:self.cid andBlock:^(FBBaseViewController * _Nonnull from, FBAreaBean * _Nonnull selectedArea, FBAreaType type, BOOL hasNext) {
                    
                    if (hasNext) {
                        
                        weakSelf.provinceHeader.isSelected = true;
                        
                        weakSelf.provinceHeader.areaBean = [weakSelf.province fetchAreaWithId:weakSelf.pid];
                        
                        [weakSelf.bridge addheader:weakSelf.provinceHeader];
                    
                        weakSelf.cityHeader.isSelected = true;
                        
                        weakSelf.cityHeader.areaBean = [weakSelf.city fetchAreaWithId:weakSelf.cid];
                        
                        [weakSelf.bridge addheader:weakSelf.cityHeader];
                        
                        [weakSelf.city updateAreas:weakSelf.pid];
                        
                        [weakSelf.pageViewController setViewControllers:@[weakSelf.region] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
                        
                        weakSelf.regionHeader.isSelected = true;
                        
                        weakSelf.regionHeader.areaBean = [weakSelf.region fetchAreaWithId:weakSelf.rid];
                        
                        [weakSelf.bridge addheader:weakSelf.regionHeader];
                        
                        [weakSelf.region updateAreas:selectedArea.areaId];

                    }
                }];
            
            } else {
                
                [self.viewControllers removeLastObject];
                
                [self.pageViewController setViewControllers:@[self.province] direction:(UIPageViewControllerNavigationDirectionForward) animated:false completion:nil];
                
                [self.province selectedArea:self.pid andBlock:^(FBBaseViewController * _Nonnull from, FBAreaBean * _Nonnull selectedArea, FBAreaType type, BOOL hasNext) {
                    
                    FBAreaViewController *province = weakSelf.viewControllers[0];
                    
                    FBAreaViewController *city = weakSelf.viewControllers[1];
                    
                    [weakSelf.pageViewController setViewControllers:@[city] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
                    
                    [city updateAreas:selectedArea.areaId];
                    
                    weakSelf.provinceHeader.isSelected = true;
                    
                    weakSelf.provinceHeader.areaBean = [province fetchAreaWithId:weakSelf.pid];
                    
                    [weakSelf.bridge addheader:weakSelf.provinceHeader];
                    
                    weakSelf.cityHeader.isSelected = true;
                    
                    weakSelf.cityHeader.areaBean = [city fetchAreaWithId:weakSelf.cid];
                    
                    [weakSelf.bridge addheader:weakSelf.cityHeader];
                    
                    [weakSelf.collectionView reloadData];
                    
                }];
            }
        }
        
    } else {
        
        [self.viewControllers removeLastObject];
        
        [self.viewControllers removeLastObject];
        
        [self.pageViewController setViewControllers:@[self.province] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
        
        [self.bridge addheader:self.provinceHeader];
        
        [weakSelf.collectionView reloadData];
    }
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger idx = [self.viewControllers indexOfObject:viewController];
    
    if (idx == NSNotFound) {
        return nil;
    }
    
    if (idx == self.viewControllers.count - 1) {
        
        return nil;
    }
    return self.viewControllers[idx + 1];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger idx = [self.viewControllers indexOfObject:viewController];
    
    if (idx  == 0 || idx == NSNotFound) {
        
        return nil;
    }
    
    return self.viewControllers[idx - 1];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *controller = (UIViewController *)pendingViewControllers.firstObject;
    
    self.currentIdx = [self.viewControllers indexOfObject:controller];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
        UIViewController *controller = (UIViewController *)previousViewControllers.firstObject;
        
        self.currentIdx = [self.viewControllers indexOfObject:controller];
    }
    
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//
//    return self.dismissAnimation;
//}
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//
//    return self.presentAnimation;
//}

@end


@implementation FBAreaPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect finalRect = CGRectMake(0, FB_SCREEN_HEIGHT / 4, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT * 3 / 4);
    
    toVC.view.frame = CGRectOffset(finalRect, 0, FB_SCREEN_HEIGHT * 3 / 4);
    
    UIView *snapView = [fromVC.view snapshotViewAfterScreenUpdates:false];
    
    snapView.frame = transitionContext.containerView.bounds;
    
    snapView.tag = 8888;
    
    UIView *cover = [[UIView alloc] initWithFrame:CGRectZero];
    
    cover.frame = transitionContext.containerView.bounds;
    
    cover.tag = 9999;
    
    cover.alpha = 0.0;
    
    cover.backgroundColor = FB_COLOR_CREATE(@"#333333");
    
    [transitionContext.containerView addSubview:snapView];
    
    [transitionContext.containerView addSubview:cover];
    
    [transitionContext.containerView addSubview:toVC.view];
    
    fromVC.view.hidden = true;
    
    [UIView  animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        toVC.view.frame = finalRect;
        
        snapView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        cover.alpha = 0.4;
    } completion:^(BOOL finished) {
        
        fromVC.view.hidden = false;
        
        [transitionContext completeTransition:true];
    }];
}


@end

@implementation FBAreaDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect initRect = [transitionContext initialFrameForViewController:fromVC];
    
    CGRect finalRect = CGRectOffset(initRect, 0, FB_SCREEN_HEIGHT * 3 / 4);
    
    [transitionContext.containerView addSubview:toVC.view];
    
    [transitionContext.containerView sendSubviewToBack:toVC.view];
    
    UIView *snapViewFrom = [transitionContext.containerView viewWithTag:8888];
    
    [snapViewFrom removeFromSuperview];
    
    toVC.view.frame = transitionContext.containerView.bounds;
    
    toVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [UIView  animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        fromVC.view.frame = finalRect;
        
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:true];
    }];
}

@end
