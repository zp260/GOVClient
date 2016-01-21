//
//  ProfesnalViewController.m
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "ProfesnalViewController.h"

@interface ProfesnalViewController ()

@end

@implementation ProfesnalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableList];
}
-(void)initTableList
{
    data = [[indexdata alloc]init];
    [data readNSUserDefaults];
    
    self._programArrays = [[NSMutableArray alloc]init];
    _ProfesPara = [[NSMutableDictionary alloc]initWithObjectsAndKeys:data.DefaultEid,@"uid",data.DefaultCst,@"cst", nil];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_ProfesnalList];
    [self getOLData:urlstr parameter:_ProfesPara];

}

-(void)getOLData:(NSString *)withUrl parameter:(NSDictionary *)dic
{
    get = [[NetGetController alloc]init];
    [get GetUrl:withUrl target:self selector:@selector(dataCheck:) parameters:dic];
}
-(void)dataCheck:(NSDictionary *)backData
{
    if (backData.count>0)
    {
        self._programArrays = [[NSMutableArray alloc]initWithArray:[backData objectForKey:@"rows"]];
        _totalPage = [backData objectForKey:@"totalPage"];
        _currentPage = [backData objectForKey:@"page"];
        
        NSLog(@"count %lu %@",(unsigned long)self._programArrays.count,self._programArrays);
        
        [self._TableView reloadData];
    }
    
    
}
-(void)moreDataBack:(NSDictionary *)backData
{
    if (backData.count>0)
    {
        _totalPage = [backData objectForKey:@"totalPage"];
        _currentPage = [backData objectForKey:@"page"];
        if (_totalPage < _currentPage)
        {
            UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"提示" message:@"所有数据加载完毕" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else
        {
            more = [[NSMutableArray alloc]initWithArray:[backData objectForKey:@"rows"]];
            //加载你的数据
            
            [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
        }
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeConfigMenu
{
    self._MenuArray  = [[NSArray alloc]initWithObjects:@"王右美    财务专家",@"李光亮    政治专家",@"赵红旗    经济专家",@"张宝林    医学专家",@"李村冯    法律专家",@"王贵        网络专家", nil];
    
}

#pragma mark - 数据代理 datasource delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self._programArrays.count+1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - table delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ([self._programArrays count]))
    {
        
        //创建loadMoreCell
        
        return _loadMoreCell;
        
    }

    static NSString *contentListIdentifier= @"Config";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:contentListIdentifier];
    if (cell ==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentListIdentifier];
    }
    else{
        //删除cell中的子对象
        while([cell.contentView.subviews lastObject]!=nil){
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            
            
        }
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    NSUInteger row= indexPath.row;
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    cell.textLabel.text= [NSString stringWithFormat:@"%@    %@",
    [[self._programArrays objectAtIndex:row] objectForKey:@"name"],[[self._programArrays objectAtIndex:row] objectForKey:@"zy"]];
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self._programArrays count])
    {
        
    }
    ProfesonContentViewController *proContent = [[ProfesonContentViewController alloc]init];
    proContent._BaseInfo = [self._programArrays objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:proContent animated:YES];
}

#pragma mark-分页相关
//加载数据的方法:
- (IBAction)loadMoreData:(id)sender
{
    if (_currentPage.intValue >=1 && _currentPage.intValue < _totalPage.intValue)
    {
        NSString *nextPage = [NSString stringWithFormat:@"%d", _currentPage.intValue +1];
        [_ProfesPara setObject:nextPage forKey:@"page"];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_ProfesnalList];
        [get GetUrl:urlstr target:self selector:@selector(moreDataBack:) parameters:_ProfesPara];
    }
    else
    {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经没有更多数据可以加载了。。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}



//添加数据到列表:



-(void) appendTableWith:(NSMutableArray *)APdata

{
    for (int i=0;i<[APdata count];i++)
    {
        NSLog(@"%@",[APdata objectAtIndex:i]);
        [self._programArrays addObject:[APdata objectAtIndex:i]];
        
    }
    NSLog(@"count %lu %@",(unsigned long)self._programArrays.count,self._programArrays);
    [self._TableView reloadData];
    
}

#pragma mark- searchbar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_ProfesPara setObject:_searchBar.text forKey:@"expname"];
    [_ProfesPara setObject:@"1" forKey:@"page"];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_ProfesnalList];
    [self getOLData:urlstr parameter:_ProfesPara];
    [_searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self initTableList];
    _searchBar.text = nil;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    
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
