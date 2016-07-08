//
//  ViewController.m
//  JCuteView
//
//  Created by 蔡杰Alan on 16/7/7.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "ViewController.h"
#import "JCuteView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JCuteView *cuteView = [[JCuteView alloc] initWithPoint:CGPointMake(25, [UIScreen mainScreen].bounds.size.height - 65) superView:self.view bubbleWidth:35 bubbleColor:[UIColor greenColor]];
     cuteView.viscosity  = 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
