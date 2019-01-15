

//
//  TbShareView.m
//  Epipe
//
//  Created by Tb on 2018/1/30.
//  Copyright © 2018年 Epipe-iOS. All rights reserved.
//

#define TbScreenWidth       ([UIScreen mainScreen].bounds.size.width)
#define TbScreenHeight      ([UIScreen mainScreen].bounds.size.height)

#define TbUIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 2.获得RGB颜色
#define TbColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]




#import "TbShareView.h"
#import "ShareCustomCollectionViewCell.h"

@interface TbShareView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *topCollectionView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic, weak)UIView *centerView;


@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)NSArray *titles;

@property (nonatomic, copy)void (^selectBlock)(NSUInteger);
@end

@implementation TbShareView


static CGFloat const timerInterval = 0.25;
static CGFloat const cellHeight = 112;
static NSString * const shareCollectionIdentifier = @"shareCollectionIdentifier";



- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TbScreenWidth, TbScreenHeight)];
        _bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        _bgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}

- (instancetype)initShareViewToView:(UIView *)toView title:(NSArray *)titles images:(NSArray *)images selectClick:(void(^)(NSUInteger))selectClick;
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titles = titles;
        self.images = images;
        self.frame = CGRectMake(0, TbScreenHeight, TbScreenWidth, [self getViewHeight]);
        [toView addSubview:self.bgView];
        [toView addSubview:self];
        [self setuptopView];
        [self setupCenterClearView];
        [self setupbottomView];
        self.selectBlock = selectClick;

    }
    return self;
}
- (CGFloat)getViewHeight
{
    NSUInteger row = self.titles.count/ 4;
    if (self.titles.count % 4 != 0) {
        row += 1;
    }
    return row * cellHeight + 49;
}


- (void)setuptopView
{
    CGFloat itemWidth = TbScreenWidth / self.titles.count;
    UICollectionViewFlowLayout *FlowLayout = [[UICollectionViewFlowLayout alloc] init];
    FlowLayout.itemSize = CGSizeMake(itemWidth, 112);
   // 最小cell之前的横向距离，如果不设置，会有默认的间距，这里要设置为0
    FlowLayout.minimumInteritemSpacing = 0;
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, TbScreenWidth,[self getViewHeight] - 49) collectionViewLayout:FlowLayout];
    self.topCollectionView.backgroundColor = [UIColor whiteColor];
    self.topCollectionView.dataSource = self;
    self.topCollectionView.delegate = self;
    [self addSubview:self.topCollectionView];
//    self.topCollectionView.layer.cornerRadius = 5.f;
//    self.topCollectionView.layer.borderColor = TbUIColorFromRGB(0xFFFFFF).CGColor;
//    self.topCollectionView.layer.borderWidth = 1.0;
    [self.topCollectionView.layer masksToBounds];
    
    [self.topCollectionView registerClass:[ShareCustomCollectionViewCell class] forCellWithReuseIdentifier:shareCollectionIdentifier];
    
}
- (void)setupCenterClearView
{
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getViewHeight] - 48, TbScreenWidth, 1)];
    centerView.backgroundColor = TbColor(242, 242, 242);
    [self addSubview:centerView];
    self.centerView = centerView;
}


- (void)setupbottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.centerView.frame), TbScreenWidth, 48)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:TbUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    cancelBtn.frame = bottomView.bounds;
    [bottomView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shareCollectionIdentifier forIndexPath:indexPath];
    cell.title  = self.titles[indexPath.item];
    cell.titeLabelColor = TbUIColorFromRGB(0x333333);
    cell.image  = self.images[indexPath.item];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectBlock) {
        self.selectBlock(indexPath.item);
    }
}

#pragma mark - 提供给外部调用的方法
- (void)show{
    [UIView animateWithDuration:timerInterval animations:^{
        _bgView.hidden = NO;
        
        CGRect NewFrame = self.frame;
        NewFrame.origin.y = TbScreenHeight - self.frame.size.height;
        self.frame = NewFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide{
    [UIView animateWithDuration:timerInterval animations:^{
        _bgView.hidden = YES;
        
        CGRect NewFrame = self.frame;
        NewFrame.origin.y = TbScreenHeight;
        self.frame = NewFrame;
        
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


@end
