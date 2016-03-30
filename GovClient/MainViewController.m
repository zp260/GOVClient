//
//  MainViewController.m
//  ProClient
//
//  Created by pipi on 15/9/25.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize userDefaults;
- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view from its nib.
    userDefaults = [NSUserDefaults standardUserDefaults];
    [self readNSUserDefaults];
//    if (_DefaultEid && _DefaultPass && _DefaultUser && _DefaultCst)
//    {
//        [self DoLogin];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)_LoginClick:(id)sender {
    
    if (self._PassTextFiled.text.length>0 && self._UserTextFiled.text.length>0)
    {
        
        [self checkUserPass];
    }
    
    //    if (false)
    //    {
    //        TabBarViewController *tab =[[TabBarViewController alloc]init];
    //        [self.navigationController pushViewController:tab animated:YES];
    //    }
}

-(void)checkUserPass
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"登录中。。";
    NSDictionary *_para = [[NSDictionary alloc]initWithObjectsAndKeys:self._UserTextFiled.text,@"loginname",self._PassTextFiled.text,@"password", nil];
    NSString *_url = [[NSString alloc]initWithFormat:@"%@%@",Url_RootAdress,loginPath];
    NetGetController *_netGet = [[NetGetController alloc]init];
    [_netGet PostUrl:_url target:self selector:@selector(LoadData:) parameters:_para];
}
-(void)LoadData:(NSDictionary *)backdata
{
    NSLog(@"%@",backdata);
    if (backdata.count>=2)
    {
        
        if ([backdata objectForKey:@"cst"] && [backdata objectForKey:@"uid"])
        {
            [userDefaults setObject:[backdata objectForKey:@"cst"] forKey:@"cst"];
            [userDefaults setObject:[backdata objectForKey:@"uid"] forKey:@"uid"];
            [self saveNSUserDefaults];
            hud.hidden=YES;
            [self DoLogin];
        }
    }
    
}
#pragma mark - NSUserDefaults
-(void)saveNSUserDefaults
{
    [userDefaults setObject:self._UserTextFiled.text forKey:@"username"];
    [userDefaults setObject:self._PassTextFiled.text forKey:@"userpass"];
    
}
-(void)readNSUserDefaults
{
    _DefaultUser = [userDefaults valueForKey:@"username"];
    _DefaultPass = [userDefaults valueForKey:@"userpass"];
    _DefaultEid = [userDefaults valueForKey:@"uid"];
    _DefaultCst = [userDefaults valueForKey:@"cst"];
    
}
-(void)DoLogin
{
    TabBarViewController *tab =[[TabBarViewController alloc]init];
    [self.navigationController pushViewController:tab animated:YES];
}
#pragma mark - textField delegate
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 310);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, self.view.frame.origin.y-offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - keyboardHight

-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}



//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置 得到键盘高度
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
}



//判断当前输入法
-(void)textViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"wewe:%@",[[UITextInputMode currentInputMode] primaryLanguage]);
    /*
     if ([[UITextInputMode currentInputMode] primaryLanguage] == @"en-US") {
     NSLog(@"en-US");
     }
     else
     {
     NSLog(@"zh-hans");
     }
     */
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
