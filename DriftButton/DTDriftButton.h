//
//  DTDriftButton.h
//  HPGCoreAnimation
//
//  Created by 何普光 on 2018/12/14.
//  Copyright © 2018 HPG. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 停靠方向
 */
typedef NS_OPTIONS(NSUInteger, DTDriftDockDirection) {
    DTDriftDockDirectionNone = 1 << 0,//无限制
    DTDriftDockDirectionLeft = 1 << 1,//左边停靠
    DTDriftDockDirectionRight = 1 << 2,//右边停靠
    DTDriftDockDirectionRightAndLeft = 1 << 3,//左右都可以停靠
    DTDriftDockDirectionNotDrap = 1 << 4,//不能拖动
};
/**
 悬浮按钮
 */
@interface DTDriftButton : UIView

/**
 初始化视图点击回调
 */
- (instancetype)initWithFrame:(CGRect)frame withClick:(void(^)(void))btnClick;

/**
背景图片
 */
@property (nonatomic, strong) UIImage * bgImage;
/**
 标题
 */
@property (nonatomic, copy) NSString * titleStr;
/**
 圆角半径
 */
@property (nonatomic, assign) CGFloat dtCornerRadius;
/**
 停靠方向
 */
@property (nonatomic, assign) DTDriftDockDirection  driftDockDirection;
/**
 停靠的范围边界
 */
@property (nonatomic) CGRect rangeBoundary;
/**
 点击回调
 */
@property (nonatomic, copy) void (^btnClickCb)(void);
@end
