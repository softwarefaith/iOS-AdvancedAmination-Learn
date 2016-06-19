//
//  ViewController.m
//  JAPPSiderMenuDemo
//
//  Created by 蔡杰 on 16/6/18.
//  Copyright © 2016年 蔡杰. All rights reserved.
//

#import "ViewController.h"
#import "JAppSildeMenu.h"

@interface ViewController ()

@property (nonatomic,strong)JAppSildeMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     self.menu =[[JAppSildeMenu alloc]initSlideMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (IBAction)triggerAction:(id)sender {
    
    [self.menu trigger];
}


@end
