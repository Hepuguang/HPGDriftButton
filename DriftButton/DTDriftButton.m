//
//  DTDriftButton.m
//  HPGCoreAnimation
//
//  Created by 何普光 on 2018/12/14.
//  Copyright © 2018 HPG. All rights reserved.
//

#import "DTDriftButton.h"

#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height
#define InitCenter CGPointMake(SelfWidth/2.f, SelfHeight/2.f)


@interface DTDriftButton()
/**
 背景图片
 */
@property (nonatomic, strong) UIImageView * bgImageView;
/**
 文字
 */
@property (nonatomic, strong) UILabel * titleLb;
/**
 内容bg视图
 */
@property (nonatomic, strong) UIView * contentView;

@end

@implementation DTDriftButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
            self.frame = CGRectMake(0, 0, 50, 50);
        }
        self.driftDockDirection = DTDriftDockDirectionNone;
        self.rangeBoundary = [UIScreen mainScreen].bounds;
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withClick:(void (^)(void))btnClick{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnClickCb = btnClick;
        self.driftDockDirection = DTDriftDockDirectionNone;
        self.rangeBoundary = [UIScreen mainScreen].bounds;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor clearColor];
    _contentView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_contentView];
    //添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selfClick)];
    [self addGestureRecognizer:tap];
    //添加拖动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
-(void)setDtCornerRadius:(CGFloat)dtCornerRadius{
    _dtCornerRadius = dtCornerRadius;
    _contentView.layer.cornerRadius = _dtCornerRadius;
    _contentView.layer.masksToBounds = YES;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _contentView.backgroundColor = backgroundColor;
}
-(void)setRangeBoundary:(CGRect)rangeBoundary{
    _rangeBoundary = rangeBoundary;
    [self changeEnd];
}
-(void)setDriftDockDirection:(DTDriftDockDirection)driftDockDirection{
    _driftDockDirection = driftDockDirection;
//    [self changeEnd];
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_contentView addSubview:_bgImageView];
        [_contentView sendSubviewToBack:_bgImageView];
    }
    return _bgImageView;
}
-(UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SelfWidth - 10, SelfHeight - 10)];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:16];
        _titleLb.adjustsFontSizeToFitWidth = YES;
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLb];
    }
    return _titleLb;
}
-(void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    self.bgImageView.image = _bgImage;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLb.text = _titleStr;
}


#pragma mark **********************事件处理**********************
-(void)pan:(UIPanGestureRecognizer *)pan{
    if (_driftDockDirection == DTDriftDockDirectionNotDrap) {
        return;
    }
    CGPoint point = [pan locationInView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan://开始
        {
        }
            break;
        case UIGestureRecognizerStateChanged://正在拖拽
        {
            [self changeViewCenter:point];
        }
            break;
        case UIGestureRecognizerStateEnded://结束
        {
            [self changeEnd];
        }
            break;
        default:
            break;
    }
}
/**
 改变视图中心
 */
-(void)changeViewCenter:(CGPoint)point{
    _contentView.center = point;
}
/**
 拖动结束
 */
-(void)changeEnd{
    CGPoint selfCenter = self.center;
    selfCenter.x += _contentView.frame.origin.x;
    selfCenter.y += _contentView.frame.origin.y;
    
    if (self.driftDockDirection & DTDriftDockDirectionNone) {
        [self setDTDriftDockDirectionNone:selfCenter];
    }
    if (self.driftDockDirection & DTDriftDockDirectionLeft) {
        [self setDTDriftDockDirectionLeft:selfCenter];
    }
    if (self.driftDockDirection & DTDriftDockDirectionRight) {
        [self setDTDriftDockDirectionRight:selfCenter];
    }
    if (self.driftDockDirection & DTDriftDockDirectionRightAndLeft) {
        [self setDTDriftDockDirectionRightAndLeft:selfCenter];
    }
    
}
/**
 停靠范围里都可以停靠
 */
-(void)setDTDriftDockDirectionNone:(CGPoint)selfCenter{
    
    self.center = selfCenter;
    _contentView.center = InitCenter;
    if (selfCenter.y < self.rangeBoundary.origin.y + SelfHeight/2.0) {
        selfCenter.y = self.rangeBoundary.origin.y + SelfHeight/2.0 + 5;
    }
    if (selfCenter.y > CGRectGetMaxY(self.rangeBoundary) - SelfHeight/2.0) {
        selfCenter.y = CGRectGetMaxY(self.rangeBoundary) - (SelfHeight/2.0 + 5);
    }
    if (selfCenter.x < self.rangeBoundary.origin.x + SelfWidth/2.0) {
        selfCenter.x = self.rangeBoundary.origin.x + SelfWidth/2.0 + 5;
    }
    if (selfCenter.x > CGRectGetMaxX(self.rangeBoundary) - SelfWidth/2.0) {
        selfCenter.x = CGRectGetMaxX(self.rangeBoundary) - (SelfWidth/2.0 + 5);
    }
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = selfCenter;
    } completion:nil];
}
/**
 停靠左边
 */
-(void)setDTDriftDockDirectionLeft:(CGPoint)selfCenter{
    self.center = selfCenter;
    _contentView.center = InitCenter;
    if (selfCenter.y < self.rangeBoundary.origin.y + SelfHeight/2.0) {
        selfCenter.y = self.rangeBoundary.origin.y + SelfHeight/2.0 + 5;
    }
    if (selfCenter.y > CGRectGetMaxY(self.rangeBoundary) - SelfHeight/2.0) {
        selfCenter.y = CGRectGetMaxY(self.rangeBoundary) - (SelfHeight/2.0 + 5);
    }
    selfCenter.x = self.rangeBoundary.origin.x +  SelfWidth/2.0 + 5;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = selfCenter;
    } completion:nil];
}
/**
 停靠右边
 */
-(void)setDTDriftDockDirectionRight:(CGPoint)selfCenter{
    self.center = selfCenter;
    _contentView.center = InitCenter;
    if (selfCenter.y < self.rangeBoundary.origin.y + SelfHeight/2.0) {
        selfCenter.y = self.rangeBoundary.origin.y + SelfHeight/2.0 + 5;
    }
    if (selfCenter.y > CGRectGetMaxY(self.rangeBoundary) - SelfHeight/2.0) {
        selfCenter.y = CGRectGetMaxY(self.rangeBoundary) - (SelfHeight/2.0 + 5);
    }
    selfCenter.x = CGRectGetMaxX(self.rangeBoundary) - (SelfWidth/2.0 + 5);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = selfCenter;
    } completion:nil];
}
/**
 左右都可以停靠
 */
-(void)setDTDriftDockDirectionRightAndLeft:(CGPoint)selfCenter{
    self.center = selfCenter;
    _contentView.center = InitCenter;
    if (selfCenter.y < self.rangeBoundary.origin.y + SelfHeight/2.0) {
        selfCenter.y = self.rangeBoundary.origin.y + SelfHeight/2.0 + 5;
    }
    if (selfCenter.y > CGRectGetMaxY(self.rangeBoundary) - SelfHeight/2.0) {
        selfCenter.y = CGRectGetMaxY(self.rangeBoundary) - (SelfHeight/2.0 + 5);
    }
    if (selfCenter.x < self.rangeBoundary.origin.x + self.rangeBoundary.size.width / 2.0 + SelfWidth/2.0) {
        selfCenter.x = self.rangeBoundary.origin.x + SelfWidth/2.0 + 5;
    }
    if (selfCenter.x > self.rangeBoundary.origin.x + self.rangeBoundary.size.width / 2.0 - SelfWidth/2.0) {
        selfCenter.x = CGRectGetMaxX(self.rangeBoundary) - (SelfWidth/2.0 + 5);
    }
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = selfCenter;
    } completion:nil];
}

/**
 点击事件
 */
-(void)selfClick{
    if (self.btnClickCb) {
        self.btnClickCb();
    }
}


@end
