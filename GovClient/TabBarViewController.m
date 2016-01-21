//
//  TabBarViewController.m
//  ProClient
//
//  Created by pipi on 15/9/25.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[NSBundle mainBundle]loadNibNamed:@"TabBarViewController" owner:self options:nil];
    
    UINavigationController *MainNav = [[UINavigationController alloc]initWithRootViewController:self._MainView];
    UINavigationController *ProfesionNav = [[UINavigationController alloc]initWithRootViewController:self._ProfesionView];
    UINavigationController *ProgramNav = [[UINavigationController alloc]initWithRootViewController:self._ProgramView];
    [self._TabbarController addChildViewController:MainNav];
    [self._TabbarController addChildViewController:ProgramNav];
    [self._TabbarController addChildViewController:ProfesionNav];

    
    [self.window addSubview:self._TabbarController.view];
    self.window.backgroundColor = [UIColor yellowColor];
    [self.window makeKeyAndVisible];
    NSLog(@"%@",self._TabbarController.viewControllers);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
