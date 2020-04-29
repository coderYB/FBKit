//
//  FBAboutViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBAboutViewController.h"

@import Masonry;
@import FBColor;
@import FBCommon;

@interface FBAboutTableHeaderView()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;
#if FBUserInfoOne

@property (nonatomic ,strong) UIView *topLine;

#elif FBUserInfoTwo

#elif FBUserInfoThree

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#endif


@end

@implementation FBAboutTableHeaderView

#if FBUserInfoOne
- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
#elif FBUserInfoTwo

#elif FBUserInfoThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}
#endif


- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @FBLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 30;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@FBProjectColor);
        
        _titleLabel.text = [NSString stringWithFormat:@"%@: %@", [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"],[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        
    }
    return _titleLabel;
}
- (void)commitInit {
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
#if FBUserInfoOne
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topLine];
    self.topLine.backgroundColor = FB_COLOR_CREATE(@"#e1e1e1");
#elif FBUserInfoTwo
    self.backgroundColor = [UIColor whiteColor];
#elif FBUserInfoThree
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.topLine];
    
    [self addSubview:self.bottomLine];
    
    self.topLine.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    self.bottomLine.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
#if FBUserInfoOne
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
        make.left.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(1);
        
        make.left.right.top.equalTo(self);
    }];
    
#elif FBUserInfoTwo
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
#elif FBUserInfoThree
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(@60);
        
        make.centerX.equalTo(self);
        
        make.top.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.bottom.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(8);
        
        make.top.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(8);
        
        make.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
    }];
#endif
}

@end
@interface FBAboutTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end


@implementation FBAboutTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#666666");
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = FB_LABEL_NEW;
        
        _subTitleLabel.font = FB_SYSTEM_FONT(15);
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = FB_COLOR_CREATE(@"#333333");
    }
    return _subTitleLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
}
- (void)setAbout:(FBAboutBean *)about {
    
    self.titleLabel.text = about.title;
    
    self.subTitleLabel.text = about.subTitle;
    
    self.bottomLineType = FBBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (about.type == FBAboutTypeSpace) {
        
        self.bottomLineType = FBBottomLineTypeNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
#if FBUserInfoOne
    
#elif FBUserInfoTwo
    
#elif FBUserInfoThree
    
    
#endif
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface FBAboutViewController ()

@property (nonatomic ,strong) FBAboutBridge *bridge;

@end

@implementation FBAboutViewController

+ (instancetype)createAbout {
    
    return [self new];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if FBPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[FBAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if FBUserInfoOne
    
    self.headerView = [[FBAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, FB_VIEWCONTROLLER_WIDTH, 100)];
#elif FBUserInfoTwo
    self.headerView = [[FBAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, FB_VIEWCONTROLLER_WIDTH, 120)];
#elif FBUserInfoThree
    self.headerView = [[FBAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, FB_VIEWCONTROLLER_WIDTH, 120)];
#endif
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.about = data;
    
    cell.bottomLineType = FBBottomLineTypeNormal;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [FBAboutBridge new];
#if FBUserInfoOne
    [self.bridge createAbout:self hasSpace:true];
#elif FBUserInfoTwo
    
    [self.bridge createAbout:self hasSpace:true];
#elif FBUserInfoThree
    [self.bridge createAbout:self hasPlace:false];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"关于我们";
}

- (BOOL)canPanResponse {
    
    return true;
}
- (void)configOwnProperties {
    
#if FBUserInfoOne
    [super configOwnProperties];
#elif FBUserInfoTwo
    [super configOwnProperties];
#elif FBUserInfoThree
    [super configOwnProperties];
#endif
    
}
@end
