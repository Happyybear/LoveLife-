//
//  HomeModel.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}
@end
