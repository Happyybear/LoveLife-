//
//  ArticalDetailViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "ArticalDetailViewController.h"

@interface ArticalDetailViewController ()

@end

@implementation ArticalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    //loadhtmlString加载类似标签的字符串，loadrequest加载的是网址
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID]]]];
    //使webview适应屏幕大小
    webView.scalesPageToFit = YES;
    
    //webView与javaScript的交互
    [self.view addSubview:webView];
}


#pragma mark _设置导航
-(void)settingNav
{
    self.titlelabel.text = @"详情";
    //返回
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
    
    //share
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//share响应事件
-(void)rightButtonClick
{
    //下载网络图片
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.readModel.pic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"566cf4ebe0f55a23e5007be9" shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession] delegate:nil];
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
