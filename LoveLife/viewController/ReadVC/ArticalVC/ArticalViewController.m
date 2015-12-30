//
//  ArticalViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "ArticalViewController.h"
#import "ReadModel.h"
#import "ArticalCell.h"
#import "ArticalDetailViewController.h"
@interface ArticalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    int _page;
}
@property(nonatomic,retain) NSMutableArray * dataArray;
@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    //请求数据
    [self createRefresh];
}

#pragma mark -请求数据
-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoNormalFooter   footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
}

#pragma mark -  加载更多数据
-(void)loadMoreData
{
    _page ++;
    [self getData];
}

#pragma mark  -刷新数据
-(void)loadNewData
{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

-(void)getData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //手动设置接受数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSArray * array = responseObject[@"data"];
        for (NSDictionary *dict in array) {
            ReadModel *model = [[ReadModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        if (_page == 0) {
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



-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark -tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

//给cell添加一个动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的动画效果3D效果
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
    if (!cell) {
        cell = [[ArticalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"];
    }
    if (self.dataArray) {
        ReadModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalDetailViewController *arVc = [[ArticalDetailViewController alloc]init];
    arVc.hidesBottomBarWhenPushed = YES;
    ReadModel *model = self.dataArray[indexPath.row];
    arVc.readModel = model;
    [self.navigationController pushViewController:arVc animated:YES];
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
