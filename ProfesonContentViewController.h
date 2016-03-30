//
//  ProfesonContentViewController.h
//  GovClient
//
//  Created by pipi on 15/9/28.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indexdata.h"
#import "NetGetController.h"
#import "checkNil.h"
@interface ProfesonContentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    indexdata *data;
    NetGetController *get;
    checkNil *NstringCheckNil;
    
    /// 专家基本信息
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_sex;
    IBOutlet UILabel *_IDCard;
    IBOutlet UILabel *_birthday;
    IBOutlet UILabel *_workUnit; //工作单位

    IBOutlet UILabel *_workUnitTel; //单位电话
    IBOutlet UILabel *_workUnitAdr; //单位地址
    IBOutlet UILabel *_zw; //职位
    IBOutlet UILabel *_ZY;
    IBOutlet UILabel *_BYSchool;//毕业院校
    IBOutlet UILabel *_Adrees; //住址
    IBOutlet UILabel *_YB; //邮编
    IBOutlet UILabel *_phone;

    //专家简历
    IBOutlet UILabel *_mainJl; //主要工作简历
    IBOutlet UILabel *_TowYearPR; //进两年的参加的招标项目
    IBOutlet UILabel *_KYResoult; //主要科研成果与工作业绩
    IBOutlet UILabel *_JoinWhere; //参加何种协会、担任何种职务
    IBOutlet UILabel *_JoinWhosGuide;//担任何家企业技术指导、名誉顾问
    
    
    //评审相关
    NSString *_eid;
    NSMutableArray *_InfoList;
    
    int _page;
    NSNumber *_currentPage;
    NSNumber *_totalPage;
    NSMutableArray *more;
    IBOutlet UITableViewCell *_loadMoreCell;
    NSMutableDictionary *_InfoListPara;
    
}
@property (strong, nonatomic) IBOutlet UIView *_BaseView;
@property (strong, nonatomic) IBOutlet UIView *_ProInfo;
@property (strong, nonatomic) UIScrollView *_ProScrool;
@property (strong, nonatomic) IBOutlet UIView *_ProAbout;
@property (strong, nonatomic) IBOutlet UISegmentedControl *_segment;
@property (strong, nonatomic) IBOutlet UITableView *_TableView;


@property (strong,nonatomic) NSArray *NameArray;// 第一列
@property (strong,nonatomic) NSArray *TelArray;// 第二列
@property (strong,nonatomic) NSArray *ProArray;// 第三列
@property (strong,nonatomic) NSArray *UnitArray;// 第四列
@property float s_height;

//上级传递
@property (strong,nonatomic) NSArray *_BaseInfo;


#define Url_InfoList @"/eph/sm/initexpeval"
@end
