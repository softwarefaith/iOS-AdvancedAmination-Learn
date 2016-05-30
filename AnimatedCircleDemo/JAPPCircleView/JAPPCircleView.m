//
//  JAPPCircleView.m
//  AnimatedCircleDemo
//
//  Created by 蔡杰Alan on 16/5/30.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "JAPPCircleView.h"
#import "JAPPCircleLayer.h"

@interface JAPPCircleView ()

@property(nonatomic,strong) JAPPCircleLayer *appCircleLayer;

@end

@implementation JAPPCircleView

+(Class)layerClass{
    return [JAPPCircleLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _appCircleLayer = [JAPPCircleLayer layer];
        _appCircleLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _appCircleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:_appCircleLayer];
    }
    return self;
}

-(void)setProgress:(CGFloat)progress{
    _appCircleLayer.progress = progress;
}

@end
