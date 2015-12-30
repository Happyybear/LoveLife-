//
//  HomeDetailViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    //头部图片
    UIImageView * _headImageView;
    //头部文字
    UILabel *_headTitleLabel;
    
}
@property (nonatomic,retain) NSMutableArray *dataArray;

//头部的数据
@property (nonatomic,retain) NSMutableDictionary *headDic;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self settingNav];
    [self createUI];
    [self loadData];
}

#pragma mark - 请求数据
-(void)loadData
{
    
    //初始化
    self.headDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[ NSString stringWithFormat:HOMEDETAIL,self.dataID.intValue ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //头部视图数据
        self.headDic = responseObject[@"data"];
        //tableView的数据
        self.dataArray = self.headDic[@"product"];
        
        //数据请求完成后刷新页面
        [self reloadHeaderView];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark --刷新头部视图
-(void)reloadHeaderView
{
    
    
    NSString *string = [NSString stringWithFormat:@"  %@",self.headDic[@"desc"]];
    CGSize maxSize = CGSizeMake(SCREEN_W-10, CGFLOAT_MAX);
    CGSize headSize = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    _headTitleLabel.frame = CGRectMake(0, _headImageView.frame.size.height-headSize.height, SCREEN_W,headSize.height);
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.headDic[@"pic"]] placeholderImage:nil];
    _headTitleLabel.text = string;
    
    
                       
}
#pragma mark-  UI
-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //头部空间
    _headImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3) imageName:nil];
//    CGSize headTitleSize = []
    _headTitleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _headImageView.frame.size.height-40, SCREEN_W, 40) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10]];
    
    _headTitleLabel.numberOfLines = 0;
    [_headImageView addSubview:_headTitleLabel];
    _tableView.tableHeaderView = _headImageView;
    
}
#pragma mark - 设置导航
-(void)settingNav
{
    self.titlelabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed@2x.png"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -delegate  TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray  *sectionArr = self.dataArray[section][@"pic"];
    return sectionArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_W - 20,200) imageName:nil];
        imageView.tag = 10;
        [cell.contentView addSubview:imageView];
    }
    
    //赋值
    UIImageView * imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    if (self.dataArray) {
        NSArray * sectionArr = self.dataArray[indexPath.section][@"pic"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArr[indexPath.row][@"pic"]] placeholderImage:[UIImage imageNamed:@"15f81d189d5044b8ff2f825c0cbf1d24"]];
    }
    
    return cell;
}


//每个section的header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    //索引
    UILabel * indexLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section + 1] textColor:RGB(255, 156, 187, 1)font:[UIFont systemFontOfSize:16]];
    indexLabel.textAlignment =NSTextAlignmentCenter;
    indexLabel.layer.borderColor = RGB(255, 156, 187, 1).CGColor;
    indexLabel.layer.borderWidth = 2;
    [bgView addSubview:indexLabel];
    
    //价格
    UIButton *priceBtn = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_W - 64, 10, 50, 40) title:nil titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(priceButtonClick)];
    priceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:priceBtn];
    
    [priceBtn setTitle:[NSString stringWithFormat:@"¥%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];
    
    //标题
    CGSize tiltleSize = [self.dataArray[section][@"title"] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    UILabel * title = [FactoryUI createLabelWithFrame:CGRectMake(indexLabel.frame.size.width + indexLabel.frame.origin.x + 10, 10, tiltleSize.width, 40) text:nil textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:18]];
    title.textAlignment = NSTextAlignmentRight;
    
    [bgView addSubview:title];
    
    title.text = self.dataArray[section][@"title"];
    return bgView;
}

//设置header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
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
