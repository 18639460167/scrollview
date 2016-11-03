//
//  ViewController.m
//  scrollview
//
//  Created by tenpastnine-ios-dev on 16/9/27.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "ViewController.h"
#import "ZSScrollview.h"
#import "DarwCircleProgressButton.h"
#import "DrawCircleProgressButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    DarwCircleProgressButton *circleBtn = [[DarwCircleProgressButton alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    circleBtn.lineWidth=  3.0f;
    [circleBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [circleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    circleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [circleBtn startAnimation:3.0 withBlock:^{
        NSLog(@"gggg");
    }];
    [self.view addSubview:circleBtn];
    
    DrawCircleProgressButton *circleBtn1 = [[DrawCircleProgressButton alloc]initWithFrame:CGRectMake(50, 150, 100, 100)];
    circleBtn1.lineWidth=  3.0f;
    [circleBtn1 setTitle:@"跳过" forState:UIControlStateNormal];
    [circleBtn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    circleBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [circleBtn1 startAnimationDuration:3.0 withBlock:^{
        NSLog(@"gggg");
    }];
    [self.view addSubview:circleBtn1];
    
//    ZSScrollview *scrollview = [[ZSScrollview alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250)];
//    [self.view addSubview:scrollview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
