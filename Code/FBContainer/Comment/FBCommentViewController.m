//
//  FBCommentViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "FBCommentViewController.h"

@import FBCache;
@import JXTAlertManager;
@import Masonry;
@import FBBridge;
@import SDWebImage;
@import FBCommon;
@import FBColor;
@import FBString;

@interface FBCommentTableViewCell ()


@end

@implementation FBCommentTableViewCell


@end

@interface FBCommentTotalTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation FBCommentTotalTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.text = @"全部评论";
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.left.mas_equalTo(15);
    }];
}
@end

@interface FBCommentRectangleTableViewCell ()

@end

@implementation FBCommentRectangleTableViewCell

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

@interface FBCommentNoMoreTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation FBCommentNoMoreTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = FB_SYSTEM_FONT(13);
        
        _titleLabel.text = @"没有更多数据了";
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

@end

@interface FBCommentFailFBableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation FBCommentFailFBableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = FB_SYSTEM_FONT(13);
        
        _titleLabel.text = @"网络错误,点击重新拉取";
        
        _titleLabel.textColor = FB_COLOR_CREATE(@FBProjectColor);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

@end

@interface FBCommentEmptyTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation FBCommentEmptyTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = FB_SYSTEM_FONT(13);
        
        _titleLabel.text = @"暂无评论";
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

@end

@interface FBCommentContentTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *moreItem;

@property (nonatomic ,strong) FBCommentBean *commentBean;

@end

@implementation FBCommentContentTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.layer.cornerRadius = 20;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = FB_LABEL_NEW;
        
        _nameLabel.font = FB_SYSTEM_FONT(15);
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = FB_COLOR_CREATE(@"#ffffff");
        
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = FB_LABEL_NEW;
        
        _timeLabel.font = FB_SYSTEM_FONT(12);
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = FB_COLOR_CREATE(@"#ffffff");
        
    }
    return _timeLabel;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.font = FB_SYSTEM_FONT(13);
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#ffffff");
        
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (UIButton *)moreItem {
    
    if (!_moreItem) {
        
        _moreItem = FB_BUTTON_NEW;
        
        [_moreItem setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    }
    return _moreItem;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.moreItem];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
    [self.moreItem addTarget:self action:@selector(onMoreItemClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setComment:(FBCommentBean *)comment {
    
    self.commentBean = comment;
    
    self.nameLabel.text = comment.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",comment.users.headImg]] placeholderImage:[UIImage imageNamed:@FBLogoIcon] options:SDWebImageRefreshCached];
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",comment.intime / 1000] FBConvertToDate:FBDateTypeDate];
    
    self.titleLabel.text = comment.content;
}
- (void)onMoreItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onMoreItemClick:)]) {
        
        [self.mDelegate onMoreItemClick:self.commentBean];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView).offset(-1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView).offset(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-40);
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        
    }];
    
    [self.moreItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
}

@end

#define BottomBar_Height FB_TABBAR_HEIGHT

@interface FBCommentViewController () <UITextFieldDelegate ,FBCommentTableViewCellDelegate>

@property (nonatomic ,strong) FBCommentBridge *bridge;

@property (nonatomic ,copy) NSString *encode;

@property (nonatomic ,strong ,readwrite) UIView *bottomBar;

@property (nonatomic ,strong) UITextField *editTF;

@property (nonatomic ,strong) UIButton *publishItem;

@property (nonatomic ,strong) UIButton *coverItem;

@property (nonatomic ,copy) FBCommentBlock block;

@property (nonatomic ,strong) FBCircleBean *circleBean;
@end

@implementation FBCommentViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andCircleBean:(FBCircleBean *)circleBean andOp:(FBCommentBlock) block {
    
    return [[self alloc] initWithEncode:encode andCircleBean:circleBean andOp:block];
}
- (instancetype)initWithEncode:(NSString *)encode andCircleBean:(FBCircleBean *)circleBean andOp:(FBCommentBlock) block{
    
    if (self = [super init]) {
        
        self.encode = encode;
        
        self.block = block;
        
        self.circleBean = circleBean;
    }
    return self;
}

- (UIView *)bottomBar {
    
    if (!_bottomBar) {
        
        _bottomBar = [[UIView alloc] init];
        
        _bottomBar.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    }
    return _bottomBar;
}
- (UITextField *)editTF {
    
    if (!_editTF) {
        
        _editTF = [[UITextField alloc] initWithFrame:CGRectZero];
        
        _editTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入评论内容" attributes:@{NSForegroundColorAttributeName: FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")) }];
        
        _editTF.textColor = [UIColor whiteColor];
        
        _editTF.font = FB_SYSTEM_FONT(13);
        
        _editTF.delegate = self;
        
        _editTF.returnKeyType = UIReturnKeyDone;
    }
    return _editTF;
}

- (UIButton *)coverItem {
    
    if (!_coverItem) {
        
        _coverItem = FB_BUTTON_NEW;
    }
    return _coverItem;
}
- (UIButton *)publishItem {
    
    if (!_publishItem) {
        
        _publishItem = FB_BUTTON_NEW;
        
        [_publishItem setTitle:@"发布" forState:UIControlStateNormal];
        
        [_publishItem setTitle:@"发布" forState:UIControlStateHighlighted];
        
        [_publishItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
        
        [_publishItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateHighlighted];
        
        _publishItem.titleLabel.font = FB_SYSTEM_FONT(14);
    }
    return _publishItem;
}

- (void)configOwnSubViews {
    
    [super configOwnSubViews];
    
    [self.tableView registerClass:[FBCommentRectangleTableViewCell class] forCellReuseIdentifier:@"rectangle"];
    
    [self.tableView registerClass:[FBCommentTotalTableViewCell class] forCellReuseIdentifier:@"total"];
    
    [self.tableView registerClass:[FBCommentNoMoreTableViewCell class] forCellReuseIdentifier:@"nomore"];
    
    [self.tableView registerClass:[FBCommentFailFBableViewCell class] forCellReuseIdentifier:@"failed"];
    
    [self.tableView registerClass:[FBCommentContentTableViewCell class] forCellReuseIdentifier:@"content"];
    
    [self.tableView registerClass:[FBCommentEmptyTableViewCell class] forCellReuseIdentifier:@"empty"];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FB_SCREEN_WIDTH, BottomBar_Height)];
    
    self.tableView.tableFooterView = footer;
    
    self.bottomBar.frame = CGRectMake(0, FB_VIEWCONTROLLER_HEIGHT - BottomBar_Height , FB_VIEWCONTROLLER_WIDTH, BottomBar_Height);
    
    self.editTF.frame = CGRectMake(15, 0, FB_VIEWCONTROLLER_WIDTH - 45, 49);
    
    self.coverItem.frame = self.bottomBar.bounds;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.publishItem.frame = CGRectMake(FB_VIEWCONTROLLER_WIDTH - 60, 0 , 40, 49);
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBCommentBean *comment = (FBCommentBean *)data;
    
    if (comment.type == WLCommentTypeRectangle) {
        
        FBCommentRectangleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"rectangle"];
        
        cell.bottomLineType = FBBottomLineTypeNone;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeTotal ) {
        
        FBCommentTotalTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"total"];
        
        cell.bottomLineType = FBBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeEmpty ) {
        
        FBCommentEmptyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"empty"];
        
        cell.bottomLineType = FBBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeFailed ) {
        
        FBCommentFailFBableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"failed"];
        
        cell.bottomLineType = FBBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeNoMore ) {
        
        FBCommentNoMoreTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nomore"];
        
        cell.bottomLineType = FBBottomLineTypeNormal;
        
        return cell;
    } else {
        
        FBCommentContentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"content"];
        
        cell.comment = data;
        
        cell.bottomLineType = FBBottomLineTypeNormal;
        
        cell.mDelegate = self;
        
        return cell;
    }
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBCommentBean *comment = (FBCommentBean *)data;
    
    if (comment.type == WLCommentTypeRectangle) {
        
        return 10;
        
    } else if (comment.type == WLCommentTypeTotal ) {
        
        return 48;
        
    } else if (comment.type == WLCommentTypeEmpty ) {
        
        return 60;
        
    } else if (comment.type == WLCommentTypeFailed ) {
        
        return 120;
        
    } else if (comment.type == WLCommentTypeNoMore ) {
        
        return 60;
    } else {
        
        CGFloat height = 60;
        
        CGFloat contnetHeight = [comment.content boundingRectWithSize:CGSizeMake(FB_SCREEN_WIDTH - 60 - 40, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FB_SYSTEM_FONT(13)} context:nil].size.height;
        
        height += contnetHeight;
        
        height += 20;
        
        return height ;
    }
}

- (void)configViewModel {
    
    self.bridge = [FBCommentBridge new];
    
    [self.bridge createComment:self encode:self.encode circle:self.circleBean];
    
    [self.tableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:self.bottomBar];
    
    [self.bottomBar addSubview:self.editTF];
    
    [self.bottomBar addSubview:self.publishItem];
    
    [self.bottomBar addSubview:self.coverItem];
    
    [self.coverItem addTarget:self action:@selector(onCoverItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.publishItem addTarget:self action:@selector(onPublishItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
    
    background.frame = self.view.bounds;
    
    self.tableView.backgroundView = background;
}

- (void)onCoverItemClick:(UIButton *)sender {
    
    if ([[FBAccountCache shared] isLogin]) {
        
        [self.editTF becomeFirstResponder];
        
        sender.enabled = false;
    } else {
        
        self.block(self, FBCommentActionTypeUnLogin, self.circleBean);
    }
}

- (void)onPublishItemClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge addComment:self.encode content:self.editTF.text commentAction:^(FBCommentBean * _Nullable commentBean, FBCircleBean * _Nonnull circleBean) {
       
        [weakSelf.editTF resignFirstResponder];

        weakSelf.editTF.text = @"";

        weakSelf.block(weakSelf, FBCommentActionTypeComment ,weakSelf.circleBean);
    }];
    
}

- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (BOOL)canPanResponse {
    return true;
}
- (void)configNaviItem {
    
    self.title = @"评论列表";
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    [self.view endEditing:true];
    
    FBCommentBean *comment = (FBCommentBean *)data;
    
    if (comment.type == WLCommentTypeFailed) {
        
        [self.tableView.mj_footer beginRefreshing];
    }
}

- (void)keyboardWillShow:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bottomBar.frame = CGRectMake(0, frame.origin.y - 49 , FB_VIEWCONTROLLER_WIDTH, 49);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat h = BottomBar_Height;
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bottomBar.frame = CGRectMake(0, frame.origin.y - h , FB_VIEWCONTROLLER_WIDTH, h);
        
        self.coverItem.enabled = true;
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return true;
}

- (void)onMoreItemClick:(FBCommentBean *)comment {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDefaultTitle(@"举报");
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"取消"]) {
            
        }
        else if ([action.title isEqualToString:@"举报"]) {
            
            weakSelf.block(weakSelf, FBCommentActionTypeReport,weakSelf.circleBean);
            
        }
    }];
}
@end
