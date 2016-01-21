//
//  ProgramContent.h
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indexdata.h"
#import "NetGetController.h"
@interface ProgramContent : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    indexdata *data;
    NetGetController *get;
    NSDictionary *_PackageDic;
    NSArray *_ZhuanjiaList;
    //标包部分
    IBOutlet UILabel *_SidXZ;//资金性质
    IBOutlet UILabel *_SidName;//标段名称
    IBOutlet UILabel *_SidMoney;//预算金额
    IBOutlet UILabel *_SidDaiBiao;//采购代表
    IBOutlet UILabel *_SidSn;//编号
    IBOutlet UILabel *_SidTel;//电话
    
    
    
    //项目信息部分
    IBOutlet UILabel *_PidName; //项目名称
    IBOutlet UILabel *_PidSN; //项目编号
    IBOutlet UILabel *_PidORG; //组织形式
    IBOutlet UILabel *_PidCg; //采购方式
    IBOutlet UILabel *_PidMoney;//项目预算金额
    
    IBOutlet UILabel *_PidHjMoney;//合计金额
    IBOutlet UILabel *_PidQT;//其他

    IBOutlet UILabel *_PidRemark;//备注
    IBOutlet UILabel *_PidWillPayMoney;//财政拨款
    IBOutlet UILabel *_PidDlORG;//代理机构
    IBOutlet UILabel *_PidCgORG;//采购机构
    IBOutlet UILabel *_PidConnect;//联系人
    IBOutlet UILabel *_PidTel;//联系电话
    
    IBOutlet UILabel *_PidStartTime;//开始时间
    IBOutlet UILabel *_PidPlace; //开标地点
    
    
    
    
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *_Segment;

@property (strong, nonatomic) IBOutlet UIView *_SgView1;
@property (strong, nonatomic) IBOutlet UIView *_SgView2;
@property (strong, nonatomic) IBOutlet UIView *_SgView3;
@property (strong, nonatomic) IBOutlet UITableView *_TableView;


@property (strong,nonatomic) NSArray *NameArray;
@property (strong,nonatomic) NSArray *TelArray;
@property (strong,nonatomic) NSArray *ProArray;
@property (strong,nonatomic) NSArray *UnitArray;
@property float equal_width;// tablbe 每列间隔
@property float s_height;

@property (strong,nonatomic) NSString *sid;

@property (strong,nonatomic) NSArray *_ProgramData;

#define Url_Pack @"/eph/sm/initsectioninfo"
#define Url_PingShenZhuanjia @"/eph/sm/initsecexps" //标包的评审专家获取url
@end
