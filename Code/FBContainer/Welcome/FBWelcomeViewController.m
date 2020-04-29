//
//  FBWelcomeViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBWelcomeViewController.h"
@import Masonry;
@import FBCommon;
@import FBColor;
@import FBImage;
@import FBString;
@import FBBridge;

@interface FBWelcomeCollectionViewCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@end

@implementation FBWelcomeCollectionViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = FB_IMAGEVIEW_NEW;
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _iconImageView.backgroundColor = [UIColor clearColor];
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImageView];
    }
    return self;
}

- (void)setIcon:(NSString *)icon {
    
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.bounds;
}

@end

@interface FBWelcomeViewController ()

@property (nonatomic ,strong) UIButton *skipItem;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) FBWelcomeBridge *bridge;

@property (nonatomic ,copy) FBWelcomeBlock block;
@end

@implementation FBWelcomeViewController

+ (instancetype)createWelcomeWithSkipBlock:(FBWelcomeBlock)block {
    
    return [[self alloc] initWithSkipBlock:block];
}

- (instancetype)initWithSkipBlock:(FBWelcomeBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIButton *)skipItem {
    
    if (!_skipItem) {
        
        _skipItem = FB_BUTTON_NEW;
        
        _skipItem.tag = 101;
        
        _skipItem.layer.borderWidth = 1;
        
        _skipItem.layer.masksToBounds = true;
        
        _skipItem.layer.cornerRadius = 5;
        
        _skipItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _skipItem;
}
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.currentPage = 0;
        
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = self.view.bounds.size;
    
    layout.itemSize = itemSize;
    
    layout.minimumLineSpacing = 0.1;
    
    layout.minimumInteritemSpacing = 0.1;
    
    layout.sectionInset = UIEdgeInsetsZero;
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.skipItem];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.centerX.mas_equalTo(@0);
        
        make.height.mas_equalTo(@20);
        
        make.bottom.mas_equalTo(@-60);
    }];
    
    [self.collectionView registerClass:[FBWelcomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
#if FBWelcomeOne
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"50"))  forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"50"));
    
    self.pageControl.numberOfPages = FBWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = FB_COLOR_CREATE(@FBProjectColor);
    
#elif FBWelcomeTwo
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.skipItem setTitleColor: FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]];
    
    self.pageControl.numberOfPages = FBWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = FB_COLOR_CREATE(@FBProjectColor);
    
#elif FBWelcomeThree
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.skipItem setTitleColor: FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiFBorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]];
    
    self.pageControl.numberOfPages = FBWelcomeImgs.count;
    
    self.pageControl.currentPageIndiFBorTintColor = FB_COLOR_CREATE(@FBProjectColor);
#elif FBWelcomeFour
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.skipItem setTitleColor: FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiFBorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]];
    
    self.pageControl.numberOfPages = FBWelcomeImgs.count;
    
    self.pageControl.currentPageIndiFBorTintColor = FB_COLOR_CREATE(@FBProjectColor);
#elif FBWelcomeFive
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = FB_COLOR_CREATE(@"#ffffff").CGColor;
    
    [self.skipItem setTitleColor: FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiFBorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]];
    
    self.pageControl.numberOfPages = FBWelcomeImgs.count;
    
    self.pageControl.currentPageIndiFBorTintColor = FB_COLOR_CREATE(@FBProjectColor);
#elif FBWelcomeSix
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.skipItem setTitleColor: FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiFBorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@FBColor]];
    
    self.pageControl.numberOfPages = FBWelcomeImgs.count;
    
    self.pageControl.currentPageIndiFBorTintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif //
    
}

- (void)configOwnProperties {
    [super configOwnProperties];
    
}
- (void)configViewModel {
    
    FBWelcomeBridge *bridge = [FBWelcomeBridge new];
    
    self.bridge = bridge;
    
#if FBWelcomeOne || FBWelcomeThree || FBWelcomeFive
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:FBWelcomeImgs canPageHidden:true welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#elif FBWelcomeTwo || FBWelcomeFour || FBWelcomeSix
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:FBWelcomeImgs canPageHidden:false welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#endif
    
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBWelcomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.icon = data;
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}

@end
