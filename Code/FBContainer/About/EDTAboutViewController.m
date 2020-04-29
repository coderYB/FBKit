//
//  EDTAboutViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTAboutViewController.h"

@import Masonry;
@import EDTColor;
@import EDTCommon;

@interface EDTAboutTableHeaderView()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;
#if EDTUserInfoOne

@property (nonatomic ,strong) UIView *topLine;

#elif EDTUserInfoTwo

#elif EDTUserInfoThree

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#endif


@end

@implementation EDTAboutTableHeaderView

#if EDTUserInfoOne
- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
#elif EDTUserInfoTwo

#elif EDTUserInfoThree

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
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @EDTLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 30;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.font = EDTSYSTEMFONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = EDTColorCreate(@EDTProjectColor);
        
        _titleLabel.text = [NSString stringWithFormat:@"%@: %@", [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"],[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        
    }
    return _titleLabel;
}
- (void)commitInit {
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
#if EDTUserInfoOne
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topLine];
    self.topLine.backgroundColor = EDTColorCreate(@"#e1e1e1");
#elif EDTUserInfoTwo
    self.backgroundColor = [UIColor whiteColor];
#elif EDTUserInfoThree
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.topLine];
    
    [self addSubview:self.bottomLine];
    
    self.topLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    self.bottomLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
#if EDTUserInfoOne
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
    
#elif EDTUserInfoTwo
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
#elif EDTUserInfoThree
    
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
@interface EDTAboutTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end


@implementation EDTAboutTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.font = EDTSYSTEMFONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = EDTColorCreate(@"#666666");
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = EDT_LABEL_NEW;
        
        _subTitleLabel.font = EDTSYSTEMFONT(15);
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = EDTColorCreate(@"#333333");
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
- (void)setAbout:(EDTAboutBean *)about {
    
    self.titleLabel.text = about.title;
    
    self.subTitleLabel.text = about.subTitle;
    
    self.bottomLineType = EDTBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (about.type == EDTAboutTypeSpace) {
        
        self.bottomLineType = EDTBottomLineTypeNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
#if EDTUserInfoOne
    
#elif EDTUserInfoTwo
    
#elif EDTUserInfoThree
    
    
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

@interface EDTAboutViewController ()

@property (nonatomic ,strong) EDTAboutBridge *bridge;

@end

@implementation EDTAboutViewController

+ (instancetype)createAbout {
    
    return [self new];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if EDTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[EDTAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if EDTUserInfoOne
    
    self.headerView = [[EDTAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, EDT_VIEWCONTROLLER_WIDTH, 100)];
#elif EDTUserInfoTwo
    self.headerView = [[EDTAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, EDT_VIEWCONTROLLER_WIDTH, 120)];
#elif EDTUserInfoThree
    self.headerView = [[EDTAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, EDT_VIEWCONTROLLER_WIDTH, 120)];
#endif
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.about = data;
    
    cell.bottomLineType = EDTBottomLineTypeNormal;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [EDTAboutBridge new];
#if EDTUserInfoOne
    [self.bridge createAbout:self hasSpace:true];
#elif EDTUserInfoTwo
    
    [self.bridge createAbout:self hasSpace:true];
#elif EDTUserInfoThree
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
    
#if EDTUserInfoOne
    [super configOwnProperties];
#elif EDTUserInfoTwo
    [super configOwnProperties];
#elif EDTUserInfoThree
    [super configOwnProperties];
#endif
    
}
@end
