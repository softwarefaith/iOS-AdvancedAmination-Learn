//
//  JCuteView.h
//  JCuteView
//
//  Created by 蔡杰Alan on 16/7/7.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCuteView : UIView

@property(nonatomic,strong) UIView *containerView;


-(instancetype)initWithPoint:(CGPoint)point
                       superView:(UIView*)superView
                       bubbleWidth:(CGFloat)bubbleWidth
                 bubbleColor:(UIColor*)bubbleColor;



@end
