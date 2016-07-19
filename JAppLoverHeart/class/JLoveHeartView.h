//
//  JLoveHeartView.h
//  JAppLoverHeart
//
//  Created by 蔡杰Alan on 16/7/19.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define JRGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RandColor JRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface JLoveHeartView : UIView

@end
