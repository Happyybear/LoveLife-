//
//  RootViewController.h
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController


@property(nonatomic,strong) UIButton * leftButton;
@property(nonatomic,strong) UIButton * rightButton;
@property(nonatomic,strong) UILabel *titlelabel;


//响应事件
-(void)setLeftButtonClick:(SEL)selector;
-(void)setRightButtonClick:(SEL)selector;
@end
