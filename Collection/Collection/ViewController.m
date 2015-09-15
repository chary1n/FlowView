//
//  ViewController.m
//  Collection
//
//  Created by Charlie.huang on 15/9/1.
//  Copyright (c) 2015年 Chalie. All rights reserved.
//

#import "ViewController.h"
#import "FlowView.h"
@interface ViewController ()
{
    FlowView *flowView;
}
@end

@implementation ViewController
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    flowView = [[FlowView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  - self.navigationController.navigationBar.frame.size.height) imageArr:@[[UIImage imageNamed:@"676x676.jpg"],[UIImage imageNamed:@"676x676-1.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676.jpg"],[UIImage imageNamed:@"676x676-1.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676.jpg"],[UIImage imageNamed:@"676x676-1.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676-2.jpg"],[UIImage imageNamed:@"676x676-2.jpg"]]];
    flowView.backgroundColor = [UIColor redColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:flowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
