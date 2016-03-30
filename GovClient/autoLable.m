//
//  autoLable.m
//  GovClient
//
//  Created by mrz on 16/3/30.
//  Copyright © 2016年 pipi. All rights reserved.
//

#import "autoLable.h"

@implementation autoLable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)AutoResetLables:(UIView *)views top_Y:(float)top_Y
{
    //获取数据重新排版
    float new_Y = 0;
    for (id obj in views)
    {
        
        if([obj isKindOfClass:[UILabel class]] )
        {
            UILabel *thisViewLable = (UILabel*)obj;
            NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
            
            CGRect rect = [thisViewLable.text boundingRectWithSize:CGSizeMake(thisViewLable.width, MAXFLOAT)
                           
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                           
                                                        attributes:attributes
                           
                                                           context:nil];
            
            if (new_Y == 0)
            {
                new_Y = top_Y;
            }
            [thisViewLable setFrame:CGRectMake(thisViewLable.left, new_Y, thisViewLable.width, rect.size.height)];
            new_Y = thisViewLable.bottom+16;
        }
        
    }

}
@end
