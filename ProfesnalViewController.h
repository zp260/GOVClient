//
//  ProfesnalViewController.h
//  GovClient
//
//  Created by pipi on 15/9/27.
//  Copyright © 2015年 pipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfesonContentViewController.h"
#import "indexdata.h"

@interface ProfesnalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    indexdata *data;
    int _page;
    NSNumber *_currentPage;
    NSNumber *_totalPage;
    NSMutableDictionary *_ProfesPara;
    
    NetGetController *get;
    NSMutableArray *more;
    IBOutlet UITableViewCell *_loadMoreCell;
    IBOutlet UISearchBar *_searchBar;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *_TableView;
@property (strong,nonatomic) NSArray *_MenuArray;
@property (strong,nonatomic) NSMutableArray *_programArrays;

#define Url_ProfesnalList @"/eph/sm/initexps"
@end
