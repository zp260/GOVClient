//
//  ProgramPacketViewController.h
//  ProClient
//
//  Created by pipi on 15/10/30.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indexdata.h"
#import "ProgramContent.h"

@interface ProgramPacketViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UITableView *_table;
@property (strong, nonatomic) IBOutlet UILabel *_TableHeader;

@property (strong,nonatomic) NSString *pid;
@property (strong,nonatomic) NSArray *packetArray;

@property int TabIdex;

@property (strong,nonatomic) NSArray *_ProjectArrayData; //项目包数据


#define Url_ProgramBaseInfoPath @"/eph/sm/initsectionsGrid"

@end
