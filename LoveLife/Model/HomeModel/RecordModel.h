//
//  RecordModel.h
//  LoveLife
//
//  Created by 王一成 on 15/12/30.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject
@property (nonatomic,copy) NSString * pub_time;
@property (nonatomic,copy) NSString * publisher_name;
@property (nonatomic,copy) NSString * publisher_icon_url;
@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSString * share_count;
@property (nonatomic,retain) NSArray * image_urls;

@end
