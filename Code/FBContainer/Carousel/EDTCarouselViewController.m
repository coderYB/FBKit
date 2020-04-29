//
//  EDTCarouselViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTCarouselViewController.h"

@import EDTBridge;
@import EDTCommon;
@import EDTColor;
@import EDTString;
@import Masonry;

@interface EDTCarouselCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong) EDTCarouselBean *carouseBean;

#if EDTCarouselOne

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIView *titleLabelBackground;
#elif EDTCarouselTwo


@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIView *titleLabelBackground;
#elif EDTCarouselThree

#endif

- (void)commitInit;

@end

@implementation EDTCarouselCollectionViewCell

#if EDTCarouselOne

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = EDTSYSTEMFONT(13);
    }
    return _titleLabel;
}
- (UIView *)titleLabelBackground {
    
    if (!_titleLabelBackground) {
        
        _titleLabelBackground = [UIView new];
        
        _titleLabelBackground.backgroundColor = [UIColor blackColor];
        
        _titleLabelBackground.alpha = 0.5;
    }
    return _titleLabelBackground;
}

#elif EDTCarouselTwo

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = EDTSYSTEMFONT(13);
    }
    return _titleLabel;
}
- (UIView *)titleLabelBackground {
    
    if (!_titleLabelBackground) {
        
        _titleLabelBackground = [UIView new];
        
        _titleLabelBackground.backgroundColor = [UIColor blackColor];
        
        _titleLabelBackground.alpha = 0.5;
    }
    return _titleLabelBackground;
}
#elif EDTCarouselThree


#endif
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
        
    }
    return self;
}
- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = EDTColorCreate(@"#e1e1e1").CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
- (void)setCarouseBean:(EDTCarouselBean *)carouseBean {
    
    self.iconImageView.image = [UIImage imageNamed:carouseBean.icon];
#if EDTCarouselOne
    
#elif EDTCarouselTwo
    self.titleLabel.text = carouseBean.title;
#elif EDTCarouselThree
    
#endif
    //
}

#if EDTCarouselOne

#elif EDTCarouselTwo

#elif EDTCarouselThree

#endif

- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
#if EDTCarouselOne
    
    [self addSubview:self.titleLabelBackground];
    
    [self addSubview:self.titleLabel];
    
#elif EDTCarouselTwo
    
    [self addSubview:self.titleLabelBackground];
    
    [self addSubview:self.titleLabel];
#elif EDTCarouselThree
    
    
    
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.bounds;
    
#if EDTCarouselTwo
    
    [self.titleLabelBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.height.mas_equalTo(30);
    }];
#elif EDTCarouselOne
    [self.titleLabelBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.height.mas_equalTo(30);
    }];
#elif EDTCarouselThree
    
    [self.titleLabelBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.height.mas_equalTo(30);
    }];
#endif
}
@end



#if EDTCarouselOne || EDTCarouselThree

#define EDTCarouselHeight EDT_SCREEN_WIDTH /  3

@interface EDTCarouselFormOneLayout : UICollectionViewFlowLayout



@end

@implementation EDTCarouselFormOneLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(EDT_SCREEN_WIDTH, EDTCarouselHeight);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 0.1;
    
    self.minimumInteritemSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end

#elif EDTCarouselTwo

#define EDTCarouselHeight EDT_SCREEN_WIDTH / 2

@interface EDTCarouselFormOneLayout : UICollectionViewFlowLayout



@end

@implementation EDTCarouselFormOneLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(EDT_SCREEN_WIDTH, EDT_SCREEN_WIDTH / 2);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 0.1;
    
    self.minimumInteritemSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define ITEM_ZOOM 0.05
//#define THE_ACTIVE_DISTANCE 230
//#define LEFT_OFFSET 60
//@interface EDTCarouselFormTwoLayout : UICollectionViewFlowLayout
//
//#define EDTCarouselHeight EDT_SCREEN_WIDTH / 2
//@end
//@implementation EDTCarouselFormTwoLayout
//
//- (void)prepareLayout {
//    [super prepareLayout];
//
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//    CGSize itemSize = CGSizeMake(EDT_SCREEN_WIDTH - 80, EDTCarouselHeight);
//
//    self.itemSize = itemSize;
//
//    self.minimumLineSpacing = 20.0f;
//
//    self.sectionInset = UIEdgeInsetsMake(60, 40, 0, 40);
//
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
//{
//    return YES;
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray * array = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
//    CGRect visiableRect;
//    visiableRect.origin = self.collectionView.contentOffset;
//    visiableRect.size = self.collectionView.bounds.size;
//
//    for (UICollectionViewLayoutAttributes * attributes in array)
//    {
//        if (CGRectIntersectsRect(attributes.frame, rect))
//        {
//            CGFloat distance = CGRectGetMidX(visiableRect) - attributes.center.x;
//            distance = ABS(distance);
//            if (distance < EDT_SCREEN_WIDTH/2 + self.itemSize.width)
//            {
//                CGFloat zoom = 1 + ITEM_ZOOM * (1 - distance/THE_ACTIVE_DISTANCE);
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
//                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0, -zoom * 25, 0);
//                attributes.alpha = zoom - ITEM_ZOOM;
//            }
//        }
//    }
//    return array;
//}
//
//- (CGPoint )targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    CGFloat offsetAdjustment = MAXFLOAT;
//
//    CGFloat horizontalCenter_X = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 20, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
//    for (UICollectionViewLayoutAttributes * attributes in array)
//    {
//        CGFloat itemHorizontalCenter_X = attributes.center.x;
//        if (ABS(itemHorizontalCenter_X - horizontalCenter_X) < ABS(offsetAdjustment))
//        {
//            offsetAdjustment = itemHorizontalCenter_X - horizontalCenter_X;
//        }
//    }
//
//    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//}
//
//@end

#endif

@interface EDTCarouselViewController ()

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) EDTCarouselBridge *bridge;

#if EDTCarouselTwo

#elif EDTCarouselOne

#elif EDTCarouselThree

@property (nonatomic ,copy) NSString *carouselTitle;

#endif
@end

@implementation EDTCarouselViewController

+ (instancetype)createCarousel {
    
    return [self new];
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.pageIndicatorTintColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"50"));
        
        _pageControl.numberOfPages = EDTCarouselImgs.count;
        
        _pageControl.currentPage = 0;

        _pageControl.currentPageIndicatorTintColor = EDTColorCreate(@EDTProjectColor);
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if EDTCarouselOne
    
    EDTCarouselFormOneLayout *layout = [EDTCarouselFormOneLayout new];
    
#elif EDTCarouselTwo
    
    EDTCarouselFormOneLayout *layout = [EDTCarouselFormOneLayout new];
#elif EDTCarouselThree
    EDTCarouselFormOneLayout *layout = [EDTCarouselFormOneLayout new];
#endif
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[EDTCarouselCollectionViewCell class] forCellWithReuseIdentifier:@"image"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.height.mas_equalTo( EDTCarouselHeight);
    }];
    
#if EDTCarouselOne
    
    self.pageControl.pageIndicatorTintColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    
    self.pageControl.currentPageIndicatorTintColor = EDTColorCreate(@"#ffffff");
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(EDTCarouselHeight - 30);
    }];
#elif EDTCarouselTwo
    
    self.pageControl.pageIndicatorTintColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    
    self.pageControl.currentPageIndicatorTintColor = EDTColorCreate(@"#ffffff");
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(EDTCarouselHeight - 30);
    }];
    
#elif EDTCarouselThree
    
    self.pageControl.pageIndiEDTorTintColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    
    self.pageControl.pageIndiEDTorTintColor = EDTColorCreate(@"#ffffff");
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(EDTCarouselHeight - 30);
    }];
#endif
}
- (void)configViewModel {
    
    EDTCarouselBridge *bridge = [EDTCarouselBridge new];
    
    self.bridge = bridge;
#if EDTCarouselTwo
    
    [bridge createCarousel:self canPageHidden:false canTimerResp:true carousels:EDTCarouselImgs style:EDTCarouselStyleNormal carouseAction:^(EDTCarouselBean * _Nonnull banner) {
        
        
    }];
    
#elif EDTCarouselOne || EDTCarouselThree
    
    [bridge createCarousel:self canPageHidden:false canTimerResp:false carousels:EDTCarouselImgs style:EDTCarouselStyleNormal carouseAction:^(EDTCarouselBean * _Nonnull carouse) {
        
    }];
    
#endif
}

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTCarouselCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:ip ];
    
    cell.carouseBean = data;
    
    return cell;
}

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}
@end
