//
//  EDTWelcomeViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTWelcomeViewController.h"
@import Masonry;
@import EDTCommon;
@import EDTColor;
@import EDTImage;
@import EDTString;
@import EDTBridge;

@interface EDTWelcomeCollectionViewCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@end

@implementation EDTWelcomeCollectionViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = EDT_IMAGEVIEW_NEW;
        
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

@interface EDTWelcomeViewController ()

@property (nonatomic ,strong) UIButton *skipItem;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) EDTWelcomeBridge *bridge;

@property (nonatomic ,copy) EDTWelcomeBlock block;
@end

@implementation EDTWelcomeViewController

+ (instancetype)createWelcomeWithSkipBlock:(EDTWelcomeBlock)block {
    
    return [[self alloc] initWithSkipBlock:block];
}

- (instancetype)initWithSkipBlock:(EDTWelcomeBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIButton *)skipItem {
    
    if (!_skipItem) {
        
        _skipItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _skipItem.tag = 101;
        
        _skipItem.layer.borderWidth = 1;
        
        _skipItem.layer.masksToBounds = true;
        
        _skipItem.layer.cornerRadius = 5;
        
        _skipItem.titleLabel.font = EDTSYSTEMFONT(15);
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
    
    [self.collectionView registerClass:[EDTWelcomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
#if EDTWelcomeOne
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"50"))  forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"50"));
    
    self.pageControl.numberOfPages = EDTWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = EDTColorCreate(@EDTProjectColor);
    
#elif EDTWelcomeTwo
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.skipItem setTitleColor: EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]];
    
    self.pageControl.numberOfPages = EDTWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = EDTColorCreate(@EDTProjectColor);
    
#elif EDTWelcomeThree
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.skipItem setTitleColor: EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiEDTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]];
    
    self.pageControl.numberOfPages = EDTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiEDTorTintColor = EDTColorCreate(@EDTProjectColor);
#elif EDTWelcomeFour
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.skipItem setTitleColor: EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiEDTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]];
    
    self.pageControl.numberOfPages = EDTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiEDTorTintColor = EDTColorCreate(@EDTProjectColor);
#elif EDTWelcomeFive
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = EDTColorCreate(@"#ffffff").CGColor;
    
    [self.skipItem setTitleColor: EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiEDTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]];
    
    self.pageControl.numberOfPages = EDTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiEDTorTintColor = EDTColorCreate(@EDTProjectColor);
#elif EDTWelcomeSix
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.skipItem setTitleColor: EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiEDTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]];
    
    self.pageControl.numberOfPages = EDTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiEDTorTintColor = EDTColorCreate(@EDTProjectColor);
#endif //
    
}

- (void)configOwnProperties {
    [super configOwnProperties];
    
}
- (void)configViewModel {
    
    EDTWelcomeBridge *bridge = [EDTWelcomeBridge new];
    
    self.bridge = bridge;
    
#if EDTWelcomeOne || EDTWelcomeThree || EDTWelcomeFive
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:EDTWelcomeImgs canPageHidden:true welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#elif EDTWelcomeTwo || EDTWelcomeFour || EDTWelcomeSix
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:EDTWelcomeImgs canPageHidden:false welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#endif
    
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTWelcomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.icon = data;
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}

@end
