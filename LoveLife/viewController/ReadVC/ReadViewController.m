//
//  ReadViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalViewController.h"
#import "RecordViewController.h"

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollerView;
    UISegmentedControl * _segementControl;
    
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
}

-(void)settingNav{
    
    //创建segement
    _segementControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //插入标题
    [_segementControl insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segementControl insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    //设置tintcolor设置字体颜色
    _segementControl.tintColor = [UIColor whiteColor];
    
    //设置默认选中
    _segementControl.selectedSegmentIndex = 0;
    
    [_segementControl addTarget:self action:@selector(changeOptions:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segementControl;
    
    
    
}

#pragma mark -segement响应方法
-(void)changeOptions:(UISegmentedControl *)segment
{
//    if (segment.selectedSegmentIndex == 1) {
//        _scrollerView.contentOffset = CGPointMake(SCREEN_W, 0);
//    }
//    else
//    {
//        _scrollerView.contentOffset = CGPointMake(0, 0);
//    }
    _scrollerView.contentOffset = CGPointMake(segment.selectedSegmentIndex * SCREEN_W, 0);
}
#pragma mark -UI
-(void)createUI
{
    //创建scrollerView
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49)];
    _scrollerView.pagingEnabled = YES;
    _scrollerView.bounces = NO;
    _scrollerView.alwaysBounceVertical = NO;
//    _scrollerView.scrollEnabled = NO;
    [self.view addSubview:_scrollerView];
    _scrollerView.contentSize = CGSizeMake(SCREEN_W * 2, 0);
    //隐藏滑动指示条
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    
    //实例化子视图控制器
    ArticalViewController * arVC = [[ArticalViewController alloc] init];
    RecordViewController * reVC = [[RecordViewController alloc]init];
    NSArray * VCArray = @[arVC,reVC];
    
    //滚动式的框架
    int i = 0;
    for (UIViewController * vc in VCArray) {
        vc.view.frame = CGRectMake(SCREEN_W * i, 0, SCREEN_W, SCREEN_H);
        [self addChildViewController:vc];
        [_scrollerView addSubview:vc.view];
        i ++;
    }
}

#pragma  mark - scrollerdelegaete方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    _segementControl.selectedSegmentIndex = scrollView.contentOffset.x / SCREEN_W;
    if (scrollView.contentOffset.x > SCREEN_W /2) {
        _segementControl.selectedSegmentIndex = 1;
    }
    else
    {
        _segementControl.selectedSegmentIndex = 0;
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
