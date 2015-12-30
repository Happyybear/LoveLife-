//
//  HomeCell.h
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeCell : UITableViewCell
{
    UILabel * _titleLabel;
    UIImageView * _imageView;
}

-(void)refreshUI:(HomeModel *)homeModel;
@end
