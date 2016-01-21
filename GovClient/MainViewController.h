//
//  MainViewController.h
//  ProClient
//
//  Created by pipi on 15/9/25.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
@interface MainViewController : UIViewController<UITextFieldDelegate>
{
    CGSize kbSize;
}
@property (strong, nonatomic) IBOutlet UIImageView *_TopWeatherImgView;
@property (strong, nonatomic) IBOutlet UITextField *_UserTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *_PassTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *_LoginBt;

@property (strong,nonatomic) NSUserDefaults *userDefaults; //存储登陆信息
@property (strong,nonatomic) NSString *DefaultUser;
@property (strong,nonatomic) NSString *DefaultPass;
@property (strong,nonatomic) NSString *DefaultEid;
@property (strong,nonatomic) NSString *DefaultCst;

#define loginPath @"/eph/sm/login"
@end
