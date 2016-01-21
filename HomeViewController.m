//
//  HomeViewController.m
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [[indexdata alloc]init];
    [data readNSUserDefaults];
    
    self._programArrays = [[NSMutableArray alloc]init];
    NSDictionary *para = [[NSDictionary alloc]initWithObjectsAndKeys:data.DefaultEid,@"uid",data.DefaultCst,@"cst", nil];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_TodayUrl];
    [self getOLData:urlstr parameter:para];
    self._SearchBar.delegate =self;

    self.title = @"今日评审";
    // Do any additional setup after loading the view from its nib.

    [self._TableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 网络数据接口处理
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


#pragma mark - 数据代理 datasource delegate
/**
 *  ViewController的这个方法返回数据条数: +1是为了显示"加载更多"的那个cell
 *
 */
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
    cell.textLabel.text=[[self._programArrays objectAtIndex:row] objectForKey:@"projectname"];
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self._programArrays count])
    {
        
    }
    else
    {
        ProgramPacketViewController *package = [[ProgramPacketViewController alloc]init];
        package.pid = [[self._programArrays objectAtIndex:indexPath.row] valueForKey:@"pid"];
        package.TabIdex = 0;
        package._ProjectArrayData = [self._programArrays objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:package animated:YES];
    }
    
}

#pragma mark-分页相关
//加载数据的方法:
- (IBAction)loadMoreData:(id)sender
{
    if (_currentPage.intValue >=1)
    {
        NSString *nextPage = [NSString stringWithFormat:@"%d", _currentPage.intValue +1];
        NSDictionary *para = [[NSDictionary alloc]initWithObjectsAndKeys:data.DefaultEid,@"uid",data.DefaultCst,@"cst",nextPage,@"page",nil];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_TodayUrl];
        [get GetUrl:urlstr target:self selector:@selector(moreDataBack:) parameters:para];
    }
    

    
}



//添加数据到列表:



-(void) appendTableWith:(NSMutableArray *)data

{
    for (int i=0;i<[data count];i++)
    {
        NSLog(@"%@",[data objectAtIndex:i]);
        [self._programArrays addObject:[data objectAtIndex:i]];
        
    }
    NSLog(@"count %lu %@",(unsigned long)self._programArrays.count,self._programArrays);
    [self._TableView reloadData];
    
}
#pragma mark-SearchBar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"开始搜索");
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
