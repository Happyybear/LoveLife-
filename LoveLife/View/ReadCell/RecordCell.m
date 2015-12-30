//
//  RecordCell.m
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "RecordCell.h"


@interface RecordCell ()

{
    //头像
    UIImageView * _photoImageView;
    //时间
    UILabel * _timeLabel;
    //pic
    UIImageView * _imageView;
    //text
    UILabel * _textLabel;
    //用户明
    UILabel * _nameLabel;
}
@end
@implementation RecordCell

- (void)awakeFromNib {
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return  self;
}

-(void)createUI
{
    _photoImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 50, 40) imageName:nil];
    
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_photoImageView.frame.origin.x + _photoImageView.frame.size.width + 10, 25, 50, 20) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
