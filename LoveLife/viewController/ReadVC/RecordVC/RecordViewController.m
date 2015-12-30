//
//  RecordViewController.m
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordModel.h"
@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
}


-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * array = responseObject[@"content"];
        for (NSDictionary * dict in array) {
            RecordModel *model = [[RecordModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        
        if (self.page == 0) {
            [self.tableView.header endRefreshing];
        }
        else
        {
            [self.tableView.footer endRefreshing];
        }

        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
