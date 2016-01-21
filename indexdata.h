//
//  indexdata.h
//  ProClient
//
//  Created by pipi on 15/10/29.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface indexdata : NSObject

/**
 *存储登陆信息
 */
@property (strong,nonatomic) NSUserDefaults *userDefaults;
@property (strong,nonatomic) NSString *DefaultUser;
@property (strong,nonatomic) NSString *DefaultPass;
@property (strong,nonatomic) NSString *DefaultEid;
@property (strong,nonatomic) NSString *DefaultCst;

@property (strong,nonatomic) NSArray *programArray;
@property (strong,nonatomic) NSString *pid;

@property (strong,nonatomic) NSString *Url_path;
@property (strong,nonatomic) NSDictionary *AfPara;


-(void)readNSUserDefaults;
-(void)LoginOut;
@end
