//
//  ViewController.m
//  AnimatedCircleDemo
//
//  Created by 蔡杰Alan on 16/5/30.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "ViewController.h"
#import "JAPPCircleView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet JAPPCircleView *circle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.circle.progress = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChange:(id)sender {
    
    self.circle.progress = ((UISlider*)sender).value;
}


@end
