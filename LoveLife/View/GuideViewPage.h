//
//  GuideViewPage.h
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewPage : UIView

@property(nonatomic,strong) UIButton * GoInButton;

-(id)initWithFrame:(CGRect)frame ImageAray:(NSArray *) imageArray;//重写init传入图片

@end
