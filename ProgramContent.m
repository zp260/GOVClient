//
//  ProgramContent.m
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import "ProgramContent.h"

@interface ProgramContent ()

@end

@implementation ProgramContent
@synthesize _ProgramData = _ProgramData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NstringCheckNil = [[checkNil alloc]init]; //初始化空字符窜处理
    
    [self configPorgramView]; //适配项目信息内容
    [self getData];
    NSLog(@"%@",self._Segment);
    self.title = @"标包内容";
    _s_height =kDeviceHeight - KNavgationBarHeight+self._Segment.height-KTabarHeight;
    
    // Do any additional setup after loading the view from its nib.
    self._SgView1.frame = CGRectMake(0, self._Segment.bottom, kDeviceWidth, _s_height);
    self._SgView2.frame = self._SgView1.frame;
    self._SgView3.frame = self._SgView1.frame;
    [self.view addSubview:self._SgView1];
    [self.view addSubview:self._SgView2];
    [self.view addSubview:self._SgView3];
    

    

}
-(void)viewWillLayoutSubviews
{
    //获取数据重新排版
    float new_Y = 0;
    for (id obj in self._SgView2.subviews)
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
                new_Y = _SidName.top;
            }
            [thisViewLable setFrame:CGRectMake(thisViewLable.left, new_Y, thisViewLable.width, rect.size.height)];
            new_Y = thisViewLable.bottom+16;
        }
        
    }
}

#pragma mark - 标包数据获取以及处理
-(void)getData
{
    data = [[indexdata alloc]init];
    [data readNSUserDefaults];
    
    NSDictionary *para = [[NSDictionary alloc]initWithObjectsAndKeys:data.DefaultEid,@"uid",data.DefaultCst,@"cst",self.sid,@"sid", nil];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_Pack];
    [self getOLData:urlstr parameter:para];
    
    //专家的
    NSDictionary *ZhuanjiaPara = [[NSDictionary alloc]initWithObjectsAndKeys:data.DefaultEid,@"uid",data.DefaultCst,@"cst",self.sid,@"sid", nil];
    NSString *ZhuanJiaListUrl = [NSString stringWithFormat:@"%@%@",Url_RootAdress,Url_PingShenZhuanjia];
    [self getZJListData:ZhuanJiaListUrl parameter:ZhuanjiaPara];
    
}
#pragma mark- 专家列表数据处理
-(void)getZJListData:(NSString *)withUrl parameter:(NSDictionary *)dic
{
    get = [[NetGetController alloc]init];
    [get GetUrl:withUrl target:self selector:@selector(ZhuanJiadDataCheck:) parameters:dic];
}
-(void)ZhuanJiadDataCheck:(NSDictionary *)backData
{
    if (backData.count>0)
    {
        _ZhuanjiaList = [backData objectForKey:@"rows"];
        [self._TableView reloadData];
    }
    
    
}

#pragma mark -  获取标包信息数据
-(void)getOLData:(NSString *)withUrl parameter:(NSDictionary *)dic
{
    get = [[NetGetController alloc]init];
    [get GetUrl:withUrl target:self selector:@selector(dataCheck:) parameters:dic];
}
-(void)dataCheck:(NSDictionary *)backData
{
    if (backData.count>0)
    {
        _PackageDic = backData;
        
        NSLog(@"标包：%@",_PackageDic);
        
        _SidName.text = [NSString stringWithFormat:@"标段名称：%@",[_PackageDic objectForKey:@"sectionname"]];
        _SidSn.text = [NSString stringWithFormat:@"标包项目编号：%@",[_PackageDic objectForKey:@"sectionnum"]];
        _SidMoney.text =[NSString stringWithFormat:@"预算金额：%@", [_PackageDic objectForKey:@"budgetfee"]];
        _SidXZ.text = [NSString stringWithFormat:@"资金性质：%@",
                       [NstringCheckNil convertNull:[_PackageDic objectForKey:@"bid_qtzj"]]];
        _SidDaiBiao.text = [NSString stringWithFormat:@"采购代表：%@",
                            [NstringCheckNil convertNull:[_PackageDic objectForKey:@"cgdb"]]];
        _SidTel.text = [NSString stringWithFormat:@"联系电话：%@",
                        [NstringCheckNil convertNull:[_PackageDic objectForKey:@"dwlxdh"]]];
        _V2Starttime.text =[NSString stringWithFormat:@"开标时间：%@",[_PackageDic valueForKey:@"kbdatatime"]];
        _V2Place.text = [NSString stringWithFormat:@"开标地点：%@",[_PackageDic valueForKey:@"kbplace"]];
       
        
        _PidStartTime.text =[NSString stringWithFormat:@"开标时间：%@",[_PackageDic valueForKey:@"kbdatatime"]];
        _PidPlace.text = [NSString stringWithFormat:@"开标地点：%@",[_PackageDic valueForKey:@"kbplace"]];
        
    }
    
    
}
#pragma mark-- 适配项目信息
-(void)configPorgramView
{
    
    if (_ProgramData)
    {
        NSLog(@"项目包:%@",_ProgramData);
        _PidName.text = [NSString stringWithFormat:@"项目名称：%@", [_ProgramData valueForKey:@"projectname"]];
        _PidSN.text = [NSString stringWithFormat:@"项目编号：%@",[_ProgramData valueForKey:@"projectnum"]];
        _PidMoney.text = [NSString stringWithFormat:@"专户管理资金：%@",[_ProgramData valueForKey:@"zhglzj"]];
        _PidCg.text = [NSString stringWithFormat:@"采购方式：%@",[_ProgramData valueForKey:@"purpattern"]];
        _PidORG.text = [NSString stringWithFormat:@"组织形式：%@",[_ProgramData valueForKey:@"organizationform"]];
        _PidCgORG.text = [NSString stringWithFormat:@"采购机构：%@",[_ProgramData valueForKey:@"purorganization"]];
        _PidDlORG.text = [NSString stringWithFormat:@"代理机构：%@",[_ProgramData valueForKey:@"agency"]];
        _PidWillPayMoney.text = [NSString stringWithFormat:@"财政拨款：%@",[_ProgramData valueForKey:@"czbk"]];
        _PidHjMoney.text = [NSString stringWithFormat:@"合计        ：%@",[_ProgramData valueForKey:@"hj"]];
        _PidQT.text = [NSString stringWithFormat:@"其他        ：%@",[NstringCheckNil convertNull:[_ProgramData valueForKey:@"qt"]]];
        
        _PidRemark.text = [NSString stringWithFormat:@"备注        ：%@",[NstringCheckNil convertNull:[_ProgramData valueForKey:@"remark"]]];
        
        
        
    }
}

-(void)makeConfigMenu
{
    
    self.NameArray  = [[NSArray alloc]initWithObjects:@"张金",@"刘红",@"马东",@"赵丽",@"曹敏",@"张金", nil];
    self.TelArray  = [[NSArray alloc]initWithObjects:@"13652645287",@"13652645287",@"13652645287",@"13652645287",@"13652645287",@"13652645287", nil];
    self.ProArray  = [[NSArray alloc]initWithObjects:@"14020219841505XXXX",@"14020219841505XXXX",@"14020219841505XXXX",@"14020219841505XXXX",@"14020219841505XXXX",@"14020219841505XXXX", nil];
//  self.UnitArray  = [[NSArray alloc]initWithObjects:@"总经理",@"设计师",@"工程师",@"工程师",@"人事经理",@"总经理", nil];
    
}
-(void)makeHeaderView
{

    
    UILabel *_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 21)];
    _name.text = @"姓名";

        int H_width = (kDeviceWidth-_name.right)/2;
    
    UILabel *_tel = [[UILabel alloc]initWithFrame:CGRectMake(_name.right, 0, H_width, 21)];
    _tel.text = @"电话";
    
    UILabel *_pro = [[UILabel alloc]initWithFrame:CGRectMake(_tel.right, 0, H_width, 21)];
    _pro.text =@"签到时间";
    

    

//    UILabel *_unit = [[UILabel alloc]initWithFrame:CGRectMake(_tel.right, 0, kDeviceWidth/4, 21)];
//    _unit.text =@"单位";
    
    _name.font = [UIFont fontWithName:@"Helvetica" size:12];
    _tel.font = [UIFont fontWithName:@"Helvetica" size:12];
    _pro.font = [UIFont fontWithName:@"Helvetica" size:12];
//    _unit.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    UIColor *blue  =[UIColor colorWithRed:43.0f/255.0f green:121.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    _name.textColor = blue;
    _tel.textColor = blue;
    _pro.textColor = blue;
//    _unit.textColor = blue;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 35)];
    
    [headerView addSubview:_name];
    [headerView addSubview:_pro];
    [headerView addSubview:_tel];
//    [headerView addSubview:_unit];
    
    self._TableView.tableHeaderView = headerView;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self makeHeaderView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SegmentClick:(id)sender
{
    switch (self._Segment.selectedSegmentIndex)
    {
        case 0:
            self._SgView1.hidden = NO;
            self._SgView2.hidden = YES;
            self._SgView3.hidden = YES;
            break;
        case 1:
            self._SgView1.hidden = YES;
            self._SgView2.hidden = NO;
            self._SgView3.hidden = YES;
            break;
        case 2:
            self._SgView1.hidden = YES;
            self._SgView2.hidden = YES;
            self._SgView3.hidden = NO;
            break;
        default:
            self._SgView1.hidden = NO;
            self._SgView2.hidden = YES;
            self._SgView3.hidden = YES;
            break;
    }
}
#pragma mark - 数据代理 datasource delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ZhuanjiaList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - table delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    

    UILabel *_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 21)];

    int H_width = (kDeviceWidth-_name.right)/2;
    
    UILabel *tel = [[UILabel alloc]initWithFrame:CGRectMake(_name.right, 0, H_width, 21)];
    UILabel *pro = [[UILabel alloc]initWithFrame:CGRectMake(tel.right, 0, H_width, 21)];
    
//    UILabel *unit = [[UILabel alloc]initWithFrame:CGRectMake(tel.right, 0, LB_width, 21)];
    
    _name.font = [UIFont fontWithName:@"Helvetica" size:12];
    tel.font = [UIFont fontWithName:@"Helvetica" size:12];
    pro.font = [UIFont fontWithName:@"Helvetica" size:12];
//    unit.font = [UIFont fontWithName:@"Helvetica" size:12];

    pro.numberOfLines =2;
//    unit.numberOfLines =2;
    NSLog(@"%@",[_ZhuanjiaList objectAtIndex:row]);
    _name.text = [[_ZhuanjiaList objectAtIndex:row] objectForKey:@"remark"];
    NSString *qdtime = [NstringCheckNil convertNull:[[_ZhuanjiaList objectAtIndex:row] objectForKey:@"qdtime"]];
    if ([qdtime  isEqual: @" "] || [qdtime isEqual: @"无"])
    {
        qdtime = @"未签到";
    }
    pro.text = qdtime;
    tel.text = [[_ZhuanjiaList objectAtIndex:row] objectForKey:@"tel"];

//    unit.text = [_UnitArray objectAtIndex:row];
    
    
    [cell.contentView addSubview:_name];
    [cell.contentView addSubview:pro];
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
