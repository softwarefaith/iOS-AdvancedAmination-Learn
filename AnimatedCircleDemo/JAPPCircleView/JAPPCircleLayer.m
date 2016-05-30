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
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay];
}

@end
