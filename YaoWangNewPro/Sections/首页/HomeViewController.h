//
//  HomeViewController.h
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-21.
//  Copyright (c) 2014年 林盼. All rights reserved.
//

#import "YWBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "OTSPageView.h"
#import "Page.h"
#import "ResultInfo.h"
#import "UserManageTool.h"
#import "HomePageModelACell.h"
#import "Search.h"
#import "OTSSearchView.h"
@interface HomeViewController : YWBaseViewController<EGORefreshTableHeaderDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,HomePageModelACellDelegate>
{
    
    EGORefreshTableHeaderView *m_RefreshHeaderView;         //下拉刷新控件
    UIScrollView *m_ScrollView;
    OTSPageView *m_PageView;
    ResultInfo *hotTopFivePage;                                   //热销图
    BOOL isRefreshingHotPage;
    BOOL isRefreshingAd;
    NSMutableArray *m_AdArray;                              //广告列表
    Search *m_Search;//搜索视图控制器
    OTSSearchView *searchView;
}
@property(retain,nonatomic)UITableView* modelATable; //模块A的列表
-(void)initHomePage;                                        //首页初始化
-(void)initData;
@end
