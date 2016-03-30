//
//  ProfesonContentViewController.m
//  GovClient
//
//  Created by pipi on 15/9/28.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "ProfesonContentViewController.h"

@interface ProfesonContentViewController ()

@end

@implementation ProfesonContentViewController

@synthesize _ProScrool;
@synthesize _ProInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    NstringCheckNil = [[checkNil alloc]init]; //初始化空字符窜处理
    data = [[indexdata alloc]init];
    [data readNSUserDefaults];
    

    
    // Do any additional setup after loading the view from its nib.
    _s_height =kDeviceHeight - KNavgationBarHeight+self._segment.height-KTabarHeight;
    self._BaseView.frame = CGRectMake(0, KNavgationBarHeight+self._segment.height, kDeviceWidth, _s_height);
    [self initProInfoViews];
    
    self._ProAbout.frame =self._BaseView.frame;
    self._ProInfo.frame = self._BaseView.frame;
    
    
    [self.view addSubview:self._BaseView];
    [self.view addSubview:self._ProAbout];
    [self.view addSubview:self._ProInfo];
    
    
    [self configBaseInfo];
    [self makeConfigMenu];
    [self makeHeaderView];
    
    _InfoListPara = [[NSMutableDictionary alloc]initWithObjectsAndKeys:data.DefaultEid,@"uid",data.DefaultCst,@"cst",_eid,@"eid", nil];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_InfoList];
    [self getOLData:urlstr parameter:_InfoListPara];
    

    
}
-(void)viewDidLayoutSubviews
{
    
    //获取数据重新排版
    float new_Y = 0;
    float new_Height = 0;
    for (id obj in self._ProInfo.subviews)
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
                new_Y = _mainJl.top;
            }
            [thisViewLable setFrame:CGRectMake(thisViewLable.left, new_Y, thisViewLable.width, rect.size.height)];
            new_Y = thisViewLable.bottom+16;
        }
        
    }
//    new_Height = new_Y;
//    self._ProInfo.frame = CGRectMake(self._ProInfo.left, self._ProInfo.top, self._ProInfo.width, new_Height);
//    NSLog(@"proinfo - ----->%@",NSStringFromCGRect(self._ProInfo.frame));
    
}

-(void)viewWillAppear:(BOOL)animated
{
    



}
-(void)initProInfoViews
{

    
    
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
        _InfoList = [[NSMutableArray alloc]initWithArray:[backData objectForKey:@"rows"]];
        _totalPage = [backData objectForKey:@"totalPage"];
        _currentPage = [backData objectForKey:@"page"];
        
        NSLog(@"count %lu %@",(unsigned long)_InfoList.count,_InfoList);
        
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

#pragma mark-分页相关
//加载数据的方法:
- (IBAction)loadMoreData:(id)sender {
    if (_currentPage.intValue >=1)
    {
        NSString *nextPage = [NSString stringWithFormat:@"%d", _currentPage.intValue +1];
        [_InfoListPara setObject:nextPage forKey:@"page"];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_InfoList];
        [get GetUrl:urlstr target:self selector:@selector(moreDataBack:) parameters:_InfoListPara];
    }

    
}

//添加数据到列表:



-(void) appendTableWith:(NSMutableArray *)data

{
    for (int i=0;i<[data count];i++)
    {
        NSLog(@"%@",[data objectAtIndex:i]);
        [_InfoList addObject:[data objectAtIndex:i]];
        
    }
    [self._TableView reloadData];
    
}

///配置基本信息界面

-(void)configBaseInfo
{
    if (self._BaseInfo)
    {
        NSLog(@"专家信息----->%@",self._BaseInfo);
        
        _eid =[self._BaseInfo valueForKey:@"eid"];
        
        _name.text = [NSString stringWithFormat:@"%@%@",_name.text,[self._BaseInfo valueForKey:@"name"]];
        _sex.text = [NSString stringWithFormat:@"%@%@",_sex.text,[self._BaseInfo valueForKey:@"sex"]];
        _IDCard.text = [NSString stringWithFormat:@"%@%@",_IDCard.text,[self._BaseInfo valueForKey:@"certificatesnum"]];
        _birthday.text = [NSString stringWithFormat:@"%@%@",_birthday.text,[self._BaseInfo valueForKey:@"birthday"]];
        _workUnit.text = [NSString stringWithFormat:@"%@%@",_workUnit.text,[self._BaseInfo valueForKey:@"gzdw"]];
        _workUnitTel.text = [NSString stringWithFormat:@"%@%@",_workUnitTel.text,[self._BaseInfo valueForKey:@"dwphone"]];
        _workUnitAdr.text = [NSString stringWithFormat:@"%@%@",_workUnitAdr.text,[self._BaseInfo valueForKey:@"gzszd"]];
        _zw.text = [NSString stringWithFormat:@"%@%@",_zw.text,[self._BaseInfo valueForKey:@"zw"]];
        _ZY.text = [NSString stringWithFormat:@"%@%@",_ZY.text,[self._BaseInfo valueForKey:@"zy"]];
        _BYSchool.text = [NSString stringWithFormat:@"%@%@",_BYSchool.text,[self._BaseInfo valueForKey:@"byyx"]];
        _Adrees.text = [NSString stringWithFormat:@"%@%@",_Adrees.text,[self._BaseInfo valueForKey:@"jtzz"]];
        _YB.text = [NSString stringWithFormat:@"%@%@",_YB.text,[self._BaseInfo valueForKey:@"yb"]];
        _phone.text = [NSString stringWithFormat:@"%@%@",_phone.text,[self._BaseInfo valueForKey:@"sjhm"]];
        
        
        _TowYearPR.text = [NSString stringWithFormat:@"%@\n%@",_TowYearPR.text,[self convertNull:[self._BaseInfo valueForKey:@"jlnccjpbdzbxm"]]];
        _KYResoult.text = [NSString stringWithFormat:@"%@\n%@",_KYResoult.text,[self convertNull:[self._BaseInfo valueForKey:@"zykycghgzyj"]]];
        _mainJl.text = [NSString stringWithFormat:@"%@\n%@",_mainJl.text,[self convertNull:[self._BaseInfo valueForKey:@"zygzjl"]]];
        _JoinWhere.text = [NSString stringWithFormat:@"%@\n%@",_JoinWhere.text,[self convertNull:[self._BaseInfo valueForKey:@"jlnccjpbdzbxm"]]];
        _JoinWhosGuide.text = [NSString stringWithFormat:@"%@\n%@",_JoinWhosGuide.text,[self convertNull:[self._BaseInfo valueForKey:@"drhjqyjszdymygw"]]];
        [self covertNilLables];
    }
}
-(void)covertNilLables
{
    for (id obj in self._BaseView.subviews)
    {
        if([obj isKindOfClass:[UILabel class]] )
        {
            UILabel *thisViewLable = (UILabel*)obj;
            thisViewLable.text = [self convertNull:thisViewLable.text];
        }
    }
}
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
    else if ([object rangeOfString:@"<null>"].location !=NSNotFound)
    {
        return [object stringByReplacingOccurrencesOfString:@"<null>" withString:@" "];
    }
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
-(void)makeHeaderView
{
    
    UILabel *_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/4, 21)];
    _name.text = @"类别";
    UILabel *_tel = [[UILabel alloc]initWithFrame:CGRectMake(_name.right, 0, kDeviceWidth-_name.width, 21)];
    _tel.text = @"评审品目";

    
    _name.font = [UIFont fontWithName:@"Helvetica" size:12];
    _tel.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    UIColor *blue  =[UIColor colorWithRed:43.0f/255.0f green:121.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    _name.textColor = blue;
    _tel.textColor = blue;

    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 35)];
    
    [headerView addSubview:_name];
    [headerView addSubview:_tel];
    
    self._TableView.tableHeaderView = headerView;
    [self._TableView reloadInputViews];
    
}
-(void)makeConfigMenu
{
    
    self.NameArray  = [[NSArray alloc]initWithObjects:@"技术专家", nil];
    self.TelArray  = [[NSArray alloc]initWithObjects:@"教授", nil];
    self.ProArray  = [[NSArray alloc]initWithObjects:@"网络设计", nil];
    self.UnitArray  = [[NSArray alloc]initWithObjects:@"通过", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentClick:(id)sender
{
    switch (self._segment.selectedSegmentIndex)
    {
        case 0:
            self._BaseView.hidden = NO;
            self._ProInfo.hidden = YES;
            self._ProAbout.hidden = YES;
            break;
        case 1:
            self._BaseView.hidden = YES;
            self._ProInfo.hidden = NO;
            self._ProAbout.hidden = YES;
            break;
        case 2:
            self._BaseView.hidden = YES;
            self._ProInfo.hidden = YES;
            self._ProAbout.hidden = NO;
            break;
        default:
            self._BaseView.hidden = NO;
            self._ProInfo.hidden = YES;
            self._ProAbout.hidden = YES;
            break;
    }

}
#pragma mark - 数据代理 datasource delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _InfoList.count+1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - table delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ([_InfoList count]))
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
    
    NSUInteger row= indexPath.row;
    
    UILabel *_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/4, 21)];
    
//    UILabel *pro = [[UILabel alloc]initWithFrame:CGRectMake(_name.right, 0, kDeviceWidth/4, 21)];
    UILabel *tel = [[UILabel alloc]initWithFrame:CGRectMake(_name.right, 0, kDeviceWidth-_name.width, 21)];
//    UILabel *unit = [[UILabel alloc]initWithFrame:CGRectMake(tel.right, 0, kDeviceWidth/4, 21)];
    
    _name.font = [UIFont fontWithName:@"Helvetica" size:12];
    tel.font = [UIFont fontWithName:@"Helvetica" size:12];
//    pro.font = [UIFont fontWithName:@"Helvetica" size:12];
//    unit.font = [UIFont fontWithName:@"Helvetica" size:12];
    
//    pro.numberOfLines =2;
//    unit.numberOfLines =2;

    _name.text = [[_InfoList objectAtIndex:row]objectForKey:@"zjlb"];
//    pro.text = [_ProArray objectAtIndex:row];
    tel.text = [[_InfoList objectAtIndex:row]objectForKey:@"zylb"];;
    
//    unit.text = [_UnitArray objectAtIndex:row];
    
    
    [cell.contentView addSubview:_name];
//    [cell.contentView addSubview:pro];
    [cell.contentView addSubview:tel];
    
//    [cell.contentView addSubview:unit];
    //    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    //    cell.textLabel.text=[self._MenuArray objectAtIndex:row];
    
    
    return cell;
    
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
