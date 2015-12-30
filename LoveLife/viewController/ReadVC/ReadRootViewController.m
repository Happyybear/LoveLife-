//
//  ReadRootViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "ReadRootViewController.h"

@interface ReadRootViewController()
{
    
}

@end

@implementation ReadRootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createUI];
    //请求数据
    [self createRefresh];
    // Do any additional setup after loading the view.
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"];
    }
   
    
    return cell;
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
