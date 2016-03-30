//
//  checkNil.m
//  GovClient
//
//  Created by mrz on 16/1/21.
//  Copyright © 2016年 pipi. All rights reserved.
//

#import "checkNil.h"

@implementation checkNil


-(NSString*)convertNull:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        return @" ";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @" ";
    }
    else if (object==nil){
        return @"无";
    }
//    else if ([object rangeOfString:@"<null>"].location !=NSNotFound)
//    {
//        return [object stringByReplacingOccurrencesOfString:@"<null>" withString:@" "];
//    }

    return object;
    
}
-(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}

@end
