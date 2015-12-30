//
//  MyTabBar.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "MyTabBar.h"
#import "HomeViewController.h"
#import "FoodViewController.h"
#import "ReadViewController.h"
#import "MyViewController.h"
#import "MusicViewController.h"
@interface MyTabBar ()

@end

@implementation MyTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewController];
    [self createTabbarIcon];
}

-(void)createViewController
{
    //实例化子视图
    //首页
    HomeViewController * homeVc = [[HomeViewController alloc] init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:homeVc];
    
//    食物
    FoodViewController * foodVc = [[FoodViewController alloc] init];
    UINavigationController * foodNav = [[UINavigationController alloc]initWithRootViewController:foodVc];
    
    
    //音乐
    MusicViewController * musicVc = [[MusicViewController alloc] init];
    UINavigationController * musicNav = [[UINavigationController alloc]initWithRootViewController:musicVc];
   
    
    //阅读
      ReadViewController  * readVc = [[ReadViewController alloc] init];
    UINavigationController * readNav = [[UINavigationController alloc]initWithRootViewController:readVc];
    
    //我的
    MyViewController * myVc = [[MyViewController alloc] init];
    UINavigationController * myNav = [[UINavigationController alloc]initWithRootViewController:myVc];
    
    
    self.viewControllers = @[homeNav,readNav,foodNav,musicNav,myNav];
    
}


-(void)createTabbarIcon
{
    //未选中的图片
    NSArray * unselectedImageArray = @[@"ic_tab_home_normal@2x",@"ic_tab_category_normal@2x",@"iconfont-iconfontmeishi",@"ic_tab_select_normal@2x",@"iconfont-yule"];
    
    //选中的图片
    NSArray * seletedImageArray = @[@"ic_tab_home_selected@2x",@"ic_tab_category_selected@2x",@"iconfont-iconfontmeishi",@"ic_tab_select_selected@2x.png",@"iconfont-yule-2"];
    
    //标题
    NSArray * titlrArray = @[@"首页",@"阅读",@"食物",@"音乐",@"我的"];
    
    
    for (int i = 0; i<self.tabBar.items.count; i++) {
        //处理图片
        UIImage * unselectImage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectImage  = [unselectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * selectedImage = [UIImage imageNamed:seletedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //
        UITabBarItem * item = self.tabBar.items[i];
        item = [item initWithTitle:titlrArray[i] image:unselectImage selectedImage:selectedImage];
        
        //设置选中时的标题的颜色
    
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    }
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
