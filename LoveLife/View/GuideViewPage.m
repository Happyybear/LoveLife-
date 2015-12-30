//
//  GuideViewPage.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "GuideViewPage.h"

@interface GuideViewPage()
{
    UIScrollView * _scroller;
}
@end
@implementation GuideViewPage



-(id)initWithFrame:(CGRect)frame ImageAray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        _scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H+64)];
        
        _scroller.pagingEnabled = YES;
        
        _scroller.bounces = NO;
        _scroller.contentSize = CGSizeMake(imageArray.count*SCREEN_W, SCREEN_H);
        [self addSubview:_scroller];
        
        //创建imageView
        for (int i = 0; i< imageArray.count; i++) {
            UIImageView * ImagV = [FactoryUI createImageViewWithFrame:CGRectMake(i*SCREEN_W, 0, SCREEN_W, SCREEN_H+64) imageName:imageArray[i]];
            ImagV.userInteractionEnabled = YES;
            [_scroller addSubview:ImagV];
            
            if (i == imageArray.count -1 ) {
                self.GoInButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.GoInButton.frame = CGRectMake(100, 100, 50, 50);
                [self.GoInButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                [ImagV addSubview:self.GoInButton];
            }
        }
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
