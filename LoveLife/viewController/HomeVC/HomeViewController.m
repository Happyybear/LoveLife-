//
//  HomeViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "HomeViewController.h"
//打开抽屉
#import "UIViewController+MMDrawerController.h"

//二维码扫描
#import "CustomViewController.h"
//广告轮播
#import "Carousel.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    Carousel * _cyclePlaying;
    UITableView * _tableView;
    int _page;
    
}

//数据源
@property(nonatomic,strong)NSMutableArray *sourceData;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self settingNav];
    //创建轮播的头视图
    [self createTableHeadView];
    
    //创建tableview
    [self createTableView];
    
    //刷新数据
    [self createRefresh];
    
    
}

-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnewData)];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //程序开始时自动刷新一次
    [_tableView.header beginRefreshing];
}

-(void)loadnewData
{
    _page = 1;
    self.sourceData = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

-(void)loadMoreData
{
    _page ++;
    [self getData];
}
#pragma mark -请求数据
-(void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary * dic in responseObject[@"data"][@"topic"]) {
            HomeModel * homeModel = [[HomeModel alloc] init];
            [homeModel setValuesForKeysWithDictionary:dic];
            [self.sourceData addObject:homeModel];
        }
        
        //数据请求成功后停止刷新,刷新界面
        if (_page == 1) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark -创建TableView
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //修改tableview的分割线
    //方法一
//    _tableView.separatorColor = [UIColor clearColor];
    //方法二
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉多余的线条
//    _tableView.tableFooterView = [[UIView alloc] init];
    
    //设置头视图
    _tableView.tableHeaderView = _cyclePlaying;
    
}

#pragma mark - tableView的协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDs"];
    if (!cell) {
        cell = [[HomeCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IDs"];
    }
    //赋值
    if (self.sourceData) {
        HomeModel * model = self.sourceData[indexPath.row];
        [cell refreshUI:model];
    }
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController *homeDetailVC = [[HomeDetailViewController alloc] init];
    
    //传值
    HomeModel *model = self.sourceData[indexPath.row];
    homeDetailVC.dataID = model.dataID;
    
    //隐藏tabbar
    homeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    
}


#pragma mark -创建tableview的头视图
-(void)createTableHeadView
{
    _cyclePlaying  = [[Carousel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/3)];
    //设置是否需要pageControl
    _cyclePlaying.needPageControl = YES;
    //是否需要无限轮播
    _cyclePlaying.infiniteLoop = YES;
    //设置pageController的位置
    _cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    
    _cyclePlaying.imageArray = @[@"shili8",@"shili2",@"shili10",@"shili13"];
    
    
}

#pragma mark -设置导航栏
-(void)settingNav{
    
    self.titlelabel.text = @"爱生活";
    
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];
    
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    
    //设置响应事件
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
    
}

#pragma mark -按钮响应事件
-(void)leftButtonClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightButtonClick
{
    //设置为no可以扫描二维码与条形码,设为yes只能扫描二维码
    CustomViewController *customVC = [[CustomViewController alloc] initWithIsQRCode:NO Block:^(NSString * result, BOOL isSucceed) {
        if (isSucceed) {
            NSLog(@"%@",result);
        }
    }];
    
    [self presentViewController:customVC animated:YES completion:nil];
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
