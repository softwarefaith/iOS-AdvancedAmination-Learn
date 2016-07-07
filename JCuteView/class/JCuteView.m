//
//  JCuteView.m
//  JCuteView
//
//  Created by 蔡杰Alan on 16/7/7.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "JCuteView.h"

@interface JCuteView (){
    
    /**
     *  @brief 园半径
     */
    CGFloat r1;
    CGFloat r2;
    
    /**
     *  @brief 圆半径位置
     */
    CGFloat x1;
    CGFloat y1;
    /**
     *  @brief 移动圆半径位置
     */
    CGFloat x2;
    CGFloat y2;
    /**
     *  @brief 两圆心距离
     */
    CGFloat centerDistance;
    
    CGFloat cosDigree;
    CGFloat sinDigree;
    
    
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    
    CGPoint pointO;
    CGPoint pointP;
    
    
    CGPoint initialPoint;
    
}

@property (nonatomic,assign) CGFloat  bubbleWidth;
@property (nonatomic,strong) UIColor  *bubbleColor;

@end


@implementation JCuteView

#pragma mark --Life
-(instancetype)initWithPoint:(CGPoint)point superView:(UIView *)superView bubbleWidth:(CGFloat)bubbleWidth bubbleColor:(UIColor *)bubbleColor{
    
    self = [super initWithFrame:CGRectMake(point.x, point.x, bubbleWidth, bubbleWidth)];
    
    if (self) {
        initialPoint = point;
        _containerView = superView;
        _bubbleWidth = bubbleWidth;
        _bubbleColor = bubbleColor;
    }
    return self;
}
@end
