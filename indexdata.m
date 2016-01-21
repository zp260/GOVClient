//
//  indexdata.m
//  ProClient
//
//  Created by pipi on 15/10/29.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "indexdata.h"

@implementation indexdata
@synthesize userDefaults;


-(void)readNSUserDefaults
{
    userDefaults = [NSUserDefaults standardUserDefaults];
    _DefaultUser = [userDefaults valueForKey:@"username"];
    _DefaultPass = [userDefaults valueForKey:@"userpass"];
    _DefaultEid = [userDefaults valueForKey:@"uid"];
    _DefaultCst = [userDefaults valueForKey:@"cst"];
    
}
-(void)LoginOut
{
    userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"cst"];
    [userDefaults setObject:nil forKey:@"username"];
    [userDefaults setObject:nil forKey:@"userpass"];
    [userDefaults setObject:nil forKey:@"uid"];
}
@end
