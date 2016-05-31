//
//  JAPPCircleLayer.m
//  AnimatedCircleDemo
//
//  Created by 蔡杰Alan on 16/5/30.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "JAPPCircleLayer.h"
/**
 *  @brief 具体详见内部的图片CircleMovingDirection.png
 */
typedef NS_ENUM(NSInteger,CircleMovingDirection) {
    CircleMovingDirectionUp,//A
    CircleMovingPointRight,//B
    CircleMovingPointDown,//C
    CircleMovingPointLeft //D
};


CGFloat const kJAppCircleBeginLastProgress = 0.5;

CGFloat const kJAppCircleOutsideRectSize = 90;

@interface JAPPCircleLayer ()

/**
 *  @brief 外接矩形
 */
@property (nonatomic,assign) CGRect outsideRect;
/**
 *  @brief 记录上次的progress ，方便做差 得出滑动方向
 */
@property (nonatomic,assign) CGFloat lastProgress;

/**
 *  @brief 记录滑动方向
 */
@property (nonatomic,assign) CircleMovingDirection direction;

@end

@implementation JAPPCircleLayer

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.lastProgress = kJAppCircleBeginLastProgress;
    }
    return self;
}

-(instancetype)initWithLayer:(JAPPCircleLayer*)layer{
    self = [super initWithLayer:layer];
    if (self) {
        
        self.progress = layer.progress;
        self.outsideRect = layer.outsideRect;
        self.direction = layer.direction;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx{
    
    //A-C1、B-C2... 的距离，当设置为正方形边长的1/3.6倍时，画出来的圆弧完美贴合圆形
    CGFloat offset = self.outsideRect.size.width / 3.6;
    //A.B.C.D实际需要移动的距离.系数为滑块偏离中点0.5的绝对值再乘以2.当滑到两端的时候，movedDistance为最大值：「外接矩形宽度的1/5」.
    CGFloat movedDistance = (self.outsideRect.size.width * 1 / 6) * fabs(self.progress-0.5)*2;

    //方便计算个点坐标，先计算外接矩形的中心点坐标
    CGPoint rectCenter = CGPointMake(CGRectGetMinX(self.outsideRect)+CGRectGetWidth(self.outsideRect)/2, CGRectGetMinY(self.outsideRect)+CGRectGetHeight(self.outsideRect)/2);
    
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance);
    CGPoint pointB = CGPointMake(self.direction == CircleMovingPointLeft ? rectCenter.x + self.outsideRect.size.width/2 : rectCenter.x + self.outsideRect.size.width/2 + movedDistance*2 ,rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x ,rectCenter.y + self.outsideRect.size.height/2 - movedDistance);
    CGPoint pointD = CGPointMake(self.direction == CircleMovingPointLeft  ? self.outsideRect.origin.x - movedDistance*2 : self.outsideRect.origin.x, rectCenter.y);
    
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.direction == CircleMovingPointLeft ? pointB.y - offset : pointB.y - offset + movedDistance);
    
    CGPoint c3 = CGPointMake(pointB.x, self.direction == CircleMovingPointLeft ? pointB.y + offset : pointB.y + offset - movedDistance);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.direction == CircleMovingPointLeft ? pointD.y + offset - movedDistance : pointD.y + offset);
    
    CGPoint c7 = CGPointMake(pointD.x, self.direction == CircleMovingPointLeft ? pointD.y - offset + movedDistance : pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    //外接虚线矩形
    UIBezierPath *reactPath = [UIBezierPath bezierPathWithRect:self.outsideRect];
    CGContextAddPath(ctx, reactPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0f);
    CGFloat dath[] = {0.5,0.5};
    CGContextSetLineDash(ctx, 0.0, dath, 2);
    CGContextStrokePath(ctx);
    
    //圆的边界
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint: pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0); //2
    CGContextDrawPath(ctx, kCGPathFillStroke); //同时给线条和线条包围的内部区域填充颜色
    

    //
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    NSArray *points = @[[NSValue valueWithCGPoint:pointA],[NSValue valueWithCGPoint:pointB],[NSValue valueWithCGPoint:pointC],[NSValue valueWithCGPoint:pointD],[NSValue valueWithCGPoint:c1],[NSValue valueWithCGPoint:c2],[NSValue valueWithCGPoint:c3],[NSValue valueWithCGPoint:c4],[NSValue valueWithCGPoint:c5],[NSValue valueWithCGPoint:c6],[NSValue valueWithCGPoint:c7],[NSValue valueWithCGPoint:c8]];
    [self drawPoint:points withContext:ctx];
    
    //连接辅助线
    UIBezierPath *helperline = [UIBezierPath bezierPath];
    [helperline moveToPoint:pointA];
    [helperline addLineToPoint:c1];
    [helperline addLineToPoint:c2];
    [helperline addLineToPoint:pointB];
    [helperline addLineToPoint:c3];
    [helperline addLineToPoint:c4];
    [helperline addLineToPoint:pointC];
    [helperline addLineToPoint:c5];
    [helperline addLineToPoint:c6];
    [helperline addLineToPoint:pointD];
    [helperline addLineToPoint:c7];
    [helperline addLineToPoint:c8];
    [helperline closePath];
    
    CGContextAddPath(ctx, helperline.CGPath);
    
    CGFloat dash2[] = {2.0, 2.0};
    CGContextSetLineDash(ctx, 0.0, dash2, 2);
    CGContextStrokePath(ctx); //给辅助线条填充颜色

    
    
}
-(void)drawPoint:(NSArray *)points withContext:(CGContextRef)ctx{
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
        CGContextFillRect(ctx, CGRectMake(point.x - 2,point.y - 2,4,4));
    }
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    if (progress <= 0.5) {
        
        self.direction = CircleMovingPointRight;
        NSLog(@"B");
        
    }else{
        
        self.direction = CircleMovingPointLeft;
        NSLog(@"D");
    }
    
    self.lastProgress = progress;
    
    CGFloat origin_x = self.position.x - kJAppCircleOutsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - kJAppCircleOutsideRectSize);
    CGFloat origin_y = self.position.y - kJAppCircleOutsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, kJAppCircleOutsideRectSize, kJAppCircleOutsideRectSize);
    
    [self setNeedsDisplay];
}

@end
