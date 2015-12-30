//
//  ReadRootViewController.h
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ReadRootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) UITableView * tableView;
@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic,assign) int page;
-(void)createRefresh;
-(void)createUI;
-(void)getData;

@end
