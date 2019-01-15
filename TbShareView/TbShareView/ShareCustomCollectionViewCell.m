
//
//  ShareCustomCollectionViewCell.m
//  Epipe
//
//  Created by Tb on 2018/1/30.
//  Copyright © 2018年 Epipe-iOS. All rights reserved.
//

#import "ShareCustomCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ShareCustomCollectionViewCell()

@property (nonatomic, weak)UIImageView *iconImageView;
@property (nonatomic, weak)UILabel *titleLabel;

@end

@implementation ShareCustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView  *iconImageView = [UIImageView new];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
}
- (void)setTiteLabelColor:(UIColor *)titeLabelColor
{
    _titeLabelColor = titeLabelColor;
    self.titleLabel.textColor = titeLabelColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setImage:(NSString *)image
{
    _image = image;
    [self.iconImageView setImage:[UIImage imageNamed:image]];
}
- (void)setupConstraint
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.contentView);
    make.top.equalTo(self.contentView.mas_top).offset(20);
    make.size.mas_equalTo(CGSizeMake(42, 42));
  }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconImageView);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
}
@end
