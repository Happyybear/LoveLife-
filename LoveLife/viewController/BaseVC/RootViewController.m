//
//  RootViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRootNav];
}

-(void)createRootNav
{
    //设置导航不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航颜色
    self.navigationController.navigationBar.barTintColor = RGB(255, 156, 187, 1);
#pragma warning  //第一种方式，修改状态栏的颜色
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //
    
    //左按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, 44, 44);
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    //标题
    self.titlelabel = [[UILabel alloc] init];
    self.titlelabel.frame = CGRectMake(0, 0, 100, 25);
    self.titlelabel.textColor = [UIColor whiteColor];
    self.titlelabel.font = [UIFont systemFontOfSize:20];
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView =self.titlelabel;
    
    //按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
}

//添加响应时间
-(void)setLeftButtonClick:(SEL)selector
{

    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setRightButtonClick:(SEL)selector
{
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
