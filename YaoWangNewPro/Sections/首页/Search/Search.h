//
//  Search.h
//  yihaodian
//
//  Created by lix on 10-12-17.
//	Updated by yangxd on 11-3-11
//  Updated by yangxd on 11-06-30  修改购买方式
//  Copyright 2010 vsc. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ASIHTTPRequest.h"
#import "SearchBar.h"

@class Trader;
@class SearchService;
@class Page;
@class ShareToSinaMicroBlog;
@class Scan;

#define TAG_SEARCH_BAR  1
#define TAG_HOME_SEARCH_BAR 2

@interface Search : UIViewController <UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    //ui
    IBOutlet UITableView *m_SearchRelationTableView;//
    IBOutlet UIButton *m_BlackBtn;//
    IBOutlet UIView *m_SearchHistoryView;//
    IBOutlet UITableView *m_SearchHistoryTableView;//
    IBOutlet UIButton *m_ScanBtn;//
	IBOutlet UIView* m_defaultHistoryView;//
    SearchBar *m_HomePageSearchBar;
    UIButton *m_HomePageSearchBarCancelBtn;
    
    NSString *m_KeyWord;
    BOOL getKeyWordRuning;												//拿关键字的线程锁；
    NSArray *m_SearchRelationArray;
    
    NSMutableArray *m_SearchHistoryArray;
}

@property(nonatomic,retain)SearchBar *m_HomePageSearchBar;
@property(nonatomic,retain)UIButton *m_HomePageSearchBarCancelBtn;

@end
