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

@interface HomeViewController : YWBaseViewController<EGORefreshTableHeaderDelegate,UIScrollViewDelegate>
{
    
    EGORefreshTableHeaderView *m_RefreshHeaderView;         //下拉刷新控件
    UIScrollView *m_ScrollView;
    OTSPageView *m_PageView;
    Page *hotTopFivePage;                                   //热销图
}
-(void)initHomePage;                                        //首页初始化
-(void)initData;
@end
