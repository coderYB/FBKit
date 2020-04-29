//
//  EDTCommentViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "EDTCommentViewController.h"

@import EDTCache;
@import JXTAlertManager;
@import Masonry;
@import EDTBridge;
@import SDWebImage;
@import EDTCommon;
@import EDTColor;
@import EDTString;

@interface EDTCommentTableViewCell ()


@end

@implementation EDTCommentTableViewCell


@end

@interface EDTCommentTotalTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation EDTCommentTotalTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
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
    
    self.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
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

@interface EDTCommentRectangleTableViewCell ()

@end

@implementation EDTCommentRectangleTableViewCell

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

@interface EDTCommentNoMoreTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation EDTCommentNoMoreTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = EDTSYSTEMFONT(13);
        
        _titleLabel.text = @"没有更多数据了";
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
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

@interface EDTCommentFailedTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation EDTCommentFailedTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = EDTSYSTEMFONT(13);
        
        _titleLabel.text = @"网络错误,点击重新拉取";
        
        _titleLabel.textColor = EDTColorCreate(@EDTProjectColor);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
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

@interface EDTCommentEmptyTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation EDTCommentEmptyTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = EDTSYSTEMFONT(13);
        
        _titleLabel.text = @"暂无评论";
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    
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

@interface EDTCommentContentTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *moreItem;

@property (nonatomic ,strong) EDTCommentBean *commentBean;

@end

@implementation EDTCommentContentTableViewCell

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
        
        _nameLabel = EDT_LABEL_NEW;
        
        _nameLabel.font = EDTSYSTEMFONT(15);
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = EDTColorCreate(@"#ffffff");
        
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = EDT_LABEL_NEW;
        
        _timeLabel.font = EDTSYSTEMFONT(12);
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = EDTColorCreate(@"#ffffff");
        
    }
    return _timeLabel;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.font = EDTSYSTEMFONT(13);
        
        _titleLabel.textColor = EDTColorCreate(@"#ffffff");
        
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (UIButton *)moreItem {
    
    if (!_moreItem) {
        
        _moreItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
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
    
    self.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    
    [self.moreItem addTarget:self action:@selector(onMoreItemClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setComment:(EDTCommentBean *)comment {
    
    self.commentBean = comment;
    
    self.nameLabel.text = comment.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",comment.users.headImg]] placeholderImage:[UIImage imageNamed:@EDTLogoIcon] options:SDWebImageRefreshCached];
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",comment.intime / 1000] EDTConvertToDate:EDTDateTypeDate];
    
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

#define BottomBar_Height EDT_TABBAR_HEIGHT

@interface EDTCommentViewController () <UITextFieldDelegate ,EDTCommentTableViewCellDelegate>

@property (nonatomic ,strong) EDTCommentBridge *bridge;

@property (nonatomic ,copy) NSString *encode;

@property (nonatomic ,strong ,readwrite) UIView *bottomBar;

@property (nonatomic ,strong) UITextField *editTF;

@property (nonatomic ,strong) UIButton *publishItem;

@property (nonatomic ,strong) UIButton *coverItem;

@property (nonatomic ,copy) EDTCommentBlock block;

@property (nonatomic ,strong) EDTCircleBean *circleBean;
@end

@implementation EDTCommentViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andCircleBean:(EDTCircleBean *)circleBean andOp:(EDTCommentBlock) block {
    
    return [[self alloc] initWithEncode:encode andCircleBean:circleBean andOp:block];
}
- (instancetype)initWithEncode:(NSString *)encode andCircleBean:(EDTCircleBean *)circleBean andOp:(EDTCommentBlock) block{
    
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
        
        _bottomBar.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));;
    }
    return _bottomBar;
}
- (UITextField *)editTF {
    
    if (!_editTF) {
        
        _editTF = [[UITextField alloc] initWithFrame:CGRectZero];
        
        _editTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入评论内容" attributes:@{NSForegroundColorAttributeName: EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")) }];
        
        _editTF.textColor = [UIColor whiteColor];
        
        _editTF.font = EDTSYSTEMFONT(13);
        
        _editTF.delegate = self;
        
        _editTF.returnKeyType = UIReturnKeyDone;
    }
    return _editTF;
}

- (UIButton *)coverItem {
    
    if (!_coverItem) {
        
        _coverItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _coverItem;
}
- (UIButton *)publishItem {
    
    if (!_publishItem) {
        
        _publishItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_publishItem setTitle:@"发布" forState:UIControlStateNormal];
        
        [_publishItem setTitle:@"发布" forState:UIControlStateHighlighted];
        
        [_publishItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
        
        [_publishItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateHighlighted];
        
        _publishItem.titleLabel.font = EDTSYSTEMFONT(14);
    }
    return _publishItem;
}

- (void)configOwnSubViews {
    
    [super configOwnSubViews];
    
    [self.tableView registerClass:[EDTCommentRectangleTableViewCell class] forCellReuseIdentifier:@"rectangle"];
    
    [self.tableView registerClass:[EDTCommentTotalTableViewCell class] forCellReuseIdentifier:@"total"];
    
    [self.tableView registerClass:[EDTCommentNoMoreTableViewCell class] forCellReuseIdentifier:@"nomore"];
    
    [self.tableView registerClass:[EDTCommentFailedTableViewCell class] forCellReuseIdentifier:@"failed"];
    
    [self.tableView registerClass:[EDTCommentContentTableViewCell class] forCellReuseIdentifier:@"content"];
    
    [self.tableView registerClass:[EDTCommentEmptyTableViewCell class] forCellReuseIdentifier:@"empty"];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EDT_SCREEN_WIDTH, BottomBar_Height)];
    
    self.tableView.tableFooterView = footer;
    
    self.bottomBar.frame = CGRectMake(0, EDT_VIEWCONTROLLER_HEIGHT - BottomBar_Height , EDT_VIEWCONTROLLER_WIDTH, BottomBar_Height);
    
    self.editTF.frame = CGRectMake(15, 0, EDT_VIEWCONTROLLER_WIDTH - 45, 49);
    
    self.coverItem.frame = self.bottomBar.bounds;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.publishItem.frame = CGRectMake(EDT_VIEWCONTROLLER_WIDTH - 60, 0 , 40, 49);
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTCommentBean *comment = (EDTCommentBean *)data;
    
    if (comment.type == WLCommentTypeRectangle) {
        
        EDTCommentRectangleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"rectangle"];
        
        cell.bottomLineType = EDTBottomLineTypeNone;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeTotal ) {
        
        EDTCommentTotalTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"total"];
        
        cell.bottomLineType = EDTBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeEmpty ) {
        
        EDTCommentEmptyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"empty"];
        
        cell.bottomLineType = EDTBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeFailed ) {
        
        EDTCommentFailedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"failed"];
        
        cell.bottomLineType = EDTBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeNoMore ) {
        
        EDTCommentNoMoreTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nomore"];
        
        cell.bottomLineType = EDTBottomLineTypeNormal;
        
        return cell;
    } else {
        
        EDTCommentContentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"content"];
        
        cell.comment = data;
        
        cell.bottomLineType = EDTBottomLineTypeNormal;
        
        cell.mDelegate = self;
        
        return cell;
    }
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTCommentBean *comment = (EDTCommentBean *)data;
    
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
        
        CGFloat contnetHeight = [comment.content boundingRectWithSize:CGSizeMake(EDT_SCREEN_WIDTH - 60 - 40, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: EDTSYSTEMFONT(13)} context:nil].size.height;
        
        height += contnetHeight;
        
        height += 20;
        
        return height ;
    }
}

- (void)configViewModel {
    
    self.bridge = [EDTCommentBridge new];
    
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
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
    
    background.frame = self.view.bounds;
    
    self.tableView.backgroundView = background;
}

- (void)onCoverItemClick:(UIButton *)sender {
    
    if ([[EDTAccountCache shared] isLogin]) {
        
        [self.editTF becomeFirstResponder];
        
        sender.enabled = false;
    } else {
        
        self.block(self, EDTCommentActionTypeUnLogin, self.circleBean);
    }
}

- (void)onPublishItemClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge addComment:self.encode content:self.editTF.text commentAction:^(EDTCommentBean * _Nullable commentBean, EDTCircleBean * _Nonnull circleBean) {
       
        [weakSelf.editTF resignFirstResponder];

        weakSelf.editTF.text = @"";

        weakSelf.block(weakSelf, EDTCommentActionTypeComment ,weakSelf.circleBean);
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
    
    EDTCommentBean *comment = (EDTCommentBean *)data;
    
    if (comment.type == WLCommentTypeFailed) {
        
        [self.tableView.mj_footer beginRefreshing];
    }
}

- (void)keyboardWillShow:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bottomBar.frame = CGRectMake(0, frame.origin.y - 49 , EDT_VIEWCONTROLLER_WIDTH, 49);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat h = BottomBar_Height;
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bottomBar.frame = CGRectMake(0, frame.origin.y - h , EDT_VIEWCONTROLLER_WIDTH, h);
        
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

- (void)onMoreItemClick:(EDTCommentBean *)comment {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDefaultTitle(@"举报");
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"取消"]) {
            
        }
        else if ([action.title isEqualToString:@"举报"]) {
            
            weakSelf.block(weakSelf, EDTCommentActionTypeReport,weakSelf.circleBean);
            
        }
    }];
}
@end
