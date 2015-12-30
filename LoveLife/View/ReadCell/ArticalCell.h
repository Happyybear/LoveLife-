//
//  ArticalCell.h
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ArticalCell : UITableViewCell
{
    //picture
    UIImageView * _imageView;
    //时间
    UILabel * _timeLabel;
    //作者
    UILabel * _authorLabel;
    //标题
    UILabel * _titleLabel;
}

-(void)refreshUI:(ReadModel *)readModel;
@end
