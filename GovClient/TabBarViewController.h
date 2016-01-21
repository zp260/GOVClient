//
//  TabBarViewController.h
//  ProClient
//
//  Created by pipi on 15/9/25.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ProfesnalViewController.h"
#import "ProgramViewController.h"
#import "CountViewController.h"

@interface TabBarViewController : UITabBarController
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IBOutlet UITabBarController *_TabbarController;
@property (strong, nonatomic) IBOutlet HomeViewController *_MainView;
@property (strong, nonatomic) IBOutlet ProfesnalViewController *_ProfesionView;
@property (strong, nonatomic) IBOutlet ProgramViewController *_ProgramView;




@end
