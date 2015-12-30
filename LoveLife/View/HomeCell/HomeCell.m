//
//  HomeCell.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, SCREEN_W - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:_titleLabel];
    
    
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y, SCREEN_W - 20, 150) imageName:nil];
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
}

-(void)refreshUI:(HomeModel *)homeModel
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:homeModel.pic] placeholderImage:[UIImage imageNamed:@"15f81d189d5044b8ff2f825c0cbf1d24"]];
    
    _titleLabel.text = homeModel.title;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
