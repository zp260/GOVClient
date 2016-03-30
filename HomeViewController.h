//
//  HomeViewController.h
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramContent.h"
#import "ProgramPacketViewController.h"
#import "indexdata.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    int _page;
    NSNumber *_currentPage;
    NSNumber *_totalPage;
    NetGetController *get;
    indexdata *data;
    NSMutableDictionary *_TodayPara;
    
    NSMutableArray *more;
    
    IBOutlet UITableViewCell *_loadMoreCell;
    IBOutlet UISearchBar *_SearchBar;
    MBProgressHUD *hud;
}
@property (strong,nonatomic) NSArray *_MenuArray;
@property (strong, nonatomic) IBOutlet UITableView *_TableView;

@property (strong,nonatomic) NSMutableArray *_programArrays;


#define Url_TodayUrl @"/eph/sm/initkbproGrid"
@end
