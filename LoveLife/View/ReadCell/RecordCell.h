//
//  RecordCell.h
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"
@interface RecordCell : UITableViewCell

-(void)refreshUI:(RecordModel *)recordModel;
@end
