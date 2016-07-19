//
//  ViewController.m
//  JAppLoverHeart
//
//  Created by 蔡杰Alan on 16/7/19.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "ViewController.h"
#import "JLoveHeartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JLoveHeartView *love = [[JLoveHeartView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    
    [self.view addSubview:love];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
