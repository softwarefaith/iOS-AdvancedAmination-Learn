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
    
    
    CGRect oldBackViewFrame;
    CGPoint initialPoint;
    CGPoint oldBackViewCenter;
    
    CAShapeLayer *shapeLayer;
    UIView *backView;
    UIBezierPath *cutePath;
    
    UIColor *fillColorForCute;
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
        
        _containerView = superView;
        [superView addSubview:self];
        
        [self config];
    }
    return self;
}

-(void)drawRect{
    
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    centerDistance = sqrtf((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
    if (centerDistance == 0) {
        cosDigree = 1;
        sinDigree = 0;
    }else{
        cosDigree = (y2-y1)/centerDistance;
        sinDigree = (x2-x1)/centerDistance;
    }
    
    r1 = oldBackViewFrame.size.width / 2 - centerDistance/self.viscosity;
    
    pointA = CGPointMake(x1-r1*cosDigree, y1+r1*sinDigree);  // A
    pointB = CGPointMake(x1+r1*cosDigree, y1-r1*sinDigree); // B
    pointD = CGPointMake(x2-r2*cosDigree, y2+r2*sinDigree); // D
    pointC = CGPointMake(x2+r2*cosDigree, y2-r2*sinDigree);// C
    pointO = CGPointMake(pointA.x + (centerDistance / 2)*sinDigree, pointA.y + (centerDistance / 2)*cosDigree);
    pointP = CGPointMake(pointB.x + (centerDistance / 2)*sinDigree, pointB.y + (centerDistance / 2)*cosDigree);
    
    backView.center = oldBackViewCenter;
    backView.bounds = CGRectMake(0, 0, r1 * 2, r1 * 2);
    backView.layer.cornerRadius = r1;
    
    cutePath = [UIBezierPath bezierPath];
    [cutePath moveToPoint:pointA];
    [cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    
    [cutePath addLineToPoint:pointC];
    [cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [cutePath addLineToPoint:pointA];
    
    if (backView.hidden == NO) {
        shapeLayer.path = [cutePath CGPath];
        shapeLayer.fillColor = [fillColorForCute CGColor];;
        [self.containerView.layer insertSublayer:shapeLayer above:self.frontView.layer];
    }
}
#pragma mark --Private
-(void)config{
    
    shapeLayer = [CAShapeLayer layer];
    self.backgroundColor = [UIColor clearColor];
    
    _frontView = [[UIView alloc] initWithFrame:CGRectMake(initialPoint.x, initialPoint.y, self.bubbleWidth, self.bubbleWidth)];
    _frontView.backgroundColor = self.bubbleColor;
    r2 = CGRectGetWidth(_frontView.frame) / 2;
    _frontView.layer.cornerRadius = r2;
    
    backView = [[UIView alloc] initWithFrame:_frontView.frame];
    r1 = CGRectGetWidth(backView.frame) / 2;
    backView.layer.cornerRadius = r1;
    backView.backgroundColor = self.bubbleColor;
    
    [self.containerView addSubview:backView];
    [self.containerView addSubview:_frontView];
    
    x1 = backView.center.x;
    y1 = backView.center.y;
    
    x2 = _frontView.center.x;
    y2 = _frontView.center.y;
    
    pointA = CGPointMake(x1 - r1, y1);
    pointB = CGPointMake(x1 + r1, y1);
    
    pointC = CGPointMake(x2 + r2, y2);
    pointD = CGPointMake(x2 + r2, y2);
    
    pointO = CGPointMake(x1 - r1, y2);
    pointP = CGPointMake(x2 + r2, y2);
    
    oldBackViewFrame = backView.frame;
    oldBackViewCenter = backView.center;
    
    backView.hidden = YES;
    [self addAniamtionLikeGameCenterBubble];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragGesture:)];
    [self.frontView addGestureRecognizer:pan];
}

-(void)handleDragGesture:(UIPanGestureRecognizer *)ges{
    
    CGPoint dragPoint = [ges locationInView:self.containerView];
    
    if (ges.state == UIGestureRecognizerStateBegan){
        
        backView.hidden = NO;
         fillColorForCute = self.bubbleColor;
        [self RemoveAniamtionLikeGameCenterBubble];
    
   
    }else if(ges.state == UIGestureRecognizerStateChanged){
        
        self.frontView.center = dragPoint;
        if (r1 <= 6) {
            fillColorForCute = [UIColor clearColor];
            backView.hidden = YES;
            [shapeLayer removeFromSuperlayer];
        }
        
        [self drawRect];
    
    }else if(ges.state == UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateFailed){
        
        backView.hidden = YES;
        [shapeLayer removeFromSuperlayer];
        fillColorForCute = [UIColor clearColor];
        [UIView animateWithDuration:0.5 delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.frontView.center = oldBackViewCenter;

        } completion:^(BOOL finished) {
            if (finished) {
                [self addAniamtionLikeGameCenterBubble];
            }

        }];
    }
    
}

-(void)addAniamtionLikeGameCenterBubble {
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = INFINITY;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 0.5;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(self.frontView.frame, self.frontView.bounds.size.width / 2 - 3, self.frontView.bounds.size.width / 2 - 3);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
   // [self.frontView.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.duration = 1;
    scaleX.values = @[@1.0,@1.1,@1.0];
    scaleX.keyTimes = @[@0.0,@0.5,@1.0];
    scaleX.repeatCount = INFINITY;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;
    scaleY.values = @[@1.0, @1.1, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
    
}
-(void)RemoveAniamtionLikeGameCenterBubble {
    [self.frontView.layer removeAllAnimations];
}

@end
