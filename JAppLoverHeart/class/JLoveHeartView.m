//
//  JLoveHeartView.m
//  JAppLoverHeart
//
//  Created by 蔡杰Alan on 16/7/19.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "JLoveHeartView.h"

@interface JLoveHeartView ()

@property (nonatomic,strong) UIColor *strokeColor;
@property (nonatomic,strong) UIColor *fillColor;

@end

@implementation JLoveHeartView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _strokeColor = [UIColor blueColor];
        _fillColor  = [UIColor whiteColor];
        
        self.backgroundColor   = [UIColor clearColor];

    }
    
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    [_strokeColor setStroke];
    [_fillColor setFill];
    
    CGFloat drawingPadding = 4.0f;
    CGFloat curveRadius = floor((CGRectGetWidth(rect) - 2*drawingPadding) / 4.0);

    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    
    //Start at bottom heart tip  floor 向下取整
    CGPoint tipLocation = CGPointMake(floor(CGRectGetWidth(rect) / 2.0), CGRectGetHeight(rect) - drawingPadding);
    [heartPath moveToPoint:tipLocation];
    
    //Move to top left start of curve
    CGPoint topLeftCurveStart = CGPointMake(drawingPadding, floor(CGRectGetHeight(rect) / 2.4));
    
    [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
    
    //Create top left curve
    [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x + curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    
    //Create top right curve
    CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
    [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x + curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    
    //Final curve to bottom heart tip
    CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
    [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y + curveRadius)];

    [heartPath fill];
    heartPath.lineWidth = 1;
    heartPath.lineCapStyle = kCGLineCapRound;
    heartPath.lineJoinStyle = kCGLineCapRound;
    [heartPath stroke];
}


@end
