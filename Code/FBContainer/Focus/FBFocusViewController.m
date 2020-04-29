//
//  FBFocusViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBFocusViewController.h"
@import Masonry;
@import SDWebImage;
@import JXTAlertManager;

@interface FBFocusTableViewCell()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@end

@implementation FBFocusTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 5;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = FB_LABEL_NEW;
        
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = FB_LABEL_NEW;
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _timeLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.timeLabel];
}
- (void)setFocus:(FBFocusBean *)focus {
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",focus.intime / 1000] s_convertToDate:SDateTypeDateStyle];
    
    self.nameLabel.text = focus.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",focus.users.headImg]] placeholderImage:[UIImage imageNamed:@FBLogoIcon] options:SDWebImageRefreshCached];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = CGRectGetHeight(self.bounds) - 30;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.bottom.mas_equalTo(-15);
        
        make.width.mas_equalTo(w);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-3);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_centerY).offset(3);
    }];
}
@end

@interface FBFocusViewController ()

@property (nonatomic ,strong) FBFocusBridge *bridge;

@property (nonatomic ,copy) FBFocusBlock block;
@end

@implementation FBFocusViewController

+ (instancetype)createBlackWithBlock:(FBFocusBlock)block {
    
    return [[self alloc] initWithBlackBlock:block];
}
- (instancetype)initWithBlackBlock:(FBFocusBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[FBFocusTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBFocusTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.focus = data;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 80;
}
- (void)configViewModel {
    
    self.bridge = [FBFocusBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createFocus:self :^(FBFocusBean * _Nonnull focus, NSIndexPath * _Nonnull ip) {
        
        [weakSelf alertShow:focus andIp:ip];
    }] ;
    
}
- (void)alertShow:(FBFocusBean *)focus andIp:(NSIndexPath *)ip {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showAlertWithTitle:[NSString stringWithFormat:@"点击确定取消对%@的关注",focus.users.nickname] message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker
        .addActionCancelTitle(@"取消")
        .addActionDefaultTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"确定"]) {
            
            [weakSelf.bridge removeFocus:focus :ip :weakSelf.block ];
            
        }
    }];
}
- (void)configNaviItem {
    
    self.title = @"黑名单";
}

- (BOOL)canPanResponse {
    
    return true;
}


@end
