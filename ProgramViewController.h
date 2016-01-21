//
//  ProgramViewController.h
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramContent.h"
#import "indexdata.h"
#import "NetGetController.h"
#import "ProgramPacketViewController.h"

@interface ProgramViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    indexdata *data;
    int _page;
    NSNumber *_currentPage;
    NSNumber *_totalPage;
    NetGetController *get;
    NSMutableArray *more;
    IBOutlet UITableViewCell *_loadMoreCell;
    NSMutableDictionary *_HistoryPara;

}

@property (strong, nonatomic) IBOutlet UITableView *_TableView;
@property (strong,nonatomic) NSArray *_MenuArray;
@property (strong,nonatomic) NSMutableArray *_programArrays;

#define Url_HistoryUrl @"/eph/sm/inithisproGrid"
@end
