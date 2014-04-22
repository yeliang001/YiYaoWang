//
//  HomeViewController.m
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-21.
//  Copyright (c) 2014年 林盼. All rights reserved.
//

#import "HomeViewController.h"
#import "ResultInfo.h"
#import "YWUserService.h"
#import "YWProductService.h"
#import "SpecialRecommendInfo.h"
#import "OTSAlertView.h"
#import "NSString+MD5Addition.h"

#define titleViewHeight 44.0
#define navHeight 49.0

#define ALERT_TAG_FORCEUPDATE_TRUE 101			// 强制更新
#define ALERT_TAG_FORCEUPDATE_FALSE 102			// 非强制更新
#define ALERT_TAG_APP_FIRST_LAUNCH 105
#define ALERT_TAG_APP_START_LAUNCH 106
#define ALERT_TAG_APP_WAKE  107

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initHomePage];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 初始化数据（页面，数据）
//首页初始化
-(void)initHomePage
{
	[self initData];
    [self initHomePageUI];
    [self setUpNewThread];
}

-(void)initData{
    
}

-(void)initHomePageUI{
    //新版本首页的省份定位不需要了
    
    CGFloat yValue = 0.0;
    if (ISIOS7) {
        yValue =20.0;
    }
    
    //logo栏
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue,320,titleViewHeight)];
    [titleView setImage:[UIImage imageNamed:@"title_bg.png"]];
    [self.view addSubview:titleView];
    [titleView release];
    
    //搜索框考虑放在导航栏上，固定下来，不滚动
    
    //
    yValue+=titleViewHeight;
    
    //scroll view
    m_ScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,yValue,320,ApplicationHeight-yValue-navHeight)];
    /*因为yValue已经计算考虑了状态栏20像素的问题，所以这里不需要判断ios7下加20的问题*/
//    if (ISIOS7) {
//        [m_ScrollView setFrame:CGRectMake(0,yValue,320,ApplicationHeight-20-yValue-navHeight)];
//    }
	[m_ScrollView setBackgroundColor:[UIColor clearColor]];
    //    [m_ScrollView setDelaysContentTouches:NO];
    [m_ScrollView setShowsVerticalScrollIndicator:NO];
    [m_ScrollView setScrollsToTop:NO];
    [m_ScrollView setAlwaysBounceVertical:YES];
    [m_ScrollView setDelegate:self];
	[self.view addSubview:m_ScrollView];
    
    //下拉刷新控件
    if (m_RefreshHeaderView!=nil) {
        [m_RefreshHeaderView release];
    }
    m_RefreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -m_ScrollView.bounds.size.height, 320, m_ScrollView.bounds.size.height)];
    m_RefreshHeaderView.delegate=self;
    [m_ScrollView addSubview:m_RefreshHeaderView];
    [m_RefreshHeaderView refreshLastUpdatedDate];
    
    //page view
    CGFloat yValueInScroll=0.0;
    m_PageView=[[OTSPageView alloc] initWithFrame:CGRectMake(0, yValueInScroll, 320, 120) delegate:self showStatusBar:YES sleepTime:5];
    [m_ScrollView addSubview:m_PageView];
}

-(void)setUpNewThread{
    
}

#pragma mark - 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)requestData
{
    [self otsDetatchMemorySafeNewThreadSelector:@selector(getHomeAd) toTarget:self withObject:nil];
    
    //自动登录
    if ([Config defaultConfig].bAutoLogin)
    {
        __block ResultInfo *result = nil;
        [self performInThreadBlock:^{
            
            NSDictionary *paramDic = @{@"username" : [Config defaultConfig].getLastUsername , @"password":[Config defaultConfig].getLastPsw};
            YWUserService *userSer = [[YWUserService alloc] init];
            result = [userSer login:paramDic];
            
        } completionInMainBlock:^{
            
            if (result.bRequestStatus)
            {
                UserInfo *user = (UserInfo *)result.resultObject;
                [Config defaultConfig].userInfo = user;
            }
        }];
    }
    
}



#pragma mark - Service
- (void)getHomeAd
{
    YWProductService *productSer = [[YWProductService alloc] init];
    ResultInfo *resultInfo = [productSer getHomeSpcecialList];
    
    if (resultInfo.bRequestStatus)
    {
//        self.bigImageAdList = ((NSArray *)resultInfo.resultObject)[0];
//        NSMutableArray *tempSmallAdList = ((NSArray *)resultInfo.resultObject)[1]; //这里是使用了iphone上的楼层数组
//        for (AdFloorInfo *floor in tempSmallAdList)
//        {
//            for (SpecialRecommendInfo *product in floor.productList)
//            {
//                [self.smallImageAdList addObject:product];
//            }
//        }
//        [self performSelectorOnMainThread:@selector(updateHomePage) withObject:nil waitUntilDone:YES];
    }
}

#pragma mark   焦点图pageview相关delegate
- (void)pageView:(OTSPageView *)pageView pageChangedTo:(NSIndexPath *)indexPath{
}

- (void)pageView:(OTSPageView *)pageView didTouchOnPage:(NSIndexPath *)indexPath{
    NSInteger index = [indexPath row];
    if (index>=[hotTopFivePage.objList count])
    {
        return;
    }
    
    
    SpecialRecommendInfo *recommendInfo = [hotTopFivePage.objList objectAtIndex:index];
    if (recommendInfo.type == kYaoSpecialBrand)
    {
        [self showAlertView:@"" alertMsg:@"品牌页面暂时没有" alertTag:12321];
    }
    else if (recommendInfo.type == kYaoSpecialCatagory)
    {
        //进入商品分类页
//        [self enterIntoCategoryList:recommendInfo.catalogId];
    }
    else if (recommendInfo.type == kYaoSpecialProduct)
    {
        //进入商品View
//        [self enterIntoProductView:recommendInfo.productId];
    }
}

- (UIView *)pageView:(OTSPageView *)pageView pageAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView *imageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)] autorelease];
    NSInteger i=[indexPath row];
    if (i>=[hotTopFivePage.objList count]) {
        imageView.image = [UIImage imageNamed:@"defaultimg320x120.png"];
    }
    else
    {
        
        //用于药店修改 Linpan
        //        NSString *fileName=[((HotPointNewVO *)[hotTopFivePage.objList objectAtIndex:i]).picUrl stringFromMD5];
        //        UIImage *image=[ImageCache getImageFromFile:fileName];
        
//        NSString *fileName=[((SpecialRecommendInfo *)[hotTopFivePage.objList objectAtIndex:i]).imageUrl stringFromMD5];
//        UIImage *image=[ImageCache getImageFromFile:fileName];
//        if (image != nil) {
//            imageView.image = image;
//        } else {
//            imageView.image = [UIImage imageNamed:@"defaultimg320x120.png"];
//        }
    }
    return imageView;
}


- (NSInteger)numberOfPagesInPageView:(OTSPageView *)pageView {
    if (hotTopFivePage==nil || hotTopFivePage.objList==nil)
    {
        return 1;
    }
    return [hotTopFivePage.objList count];
}

//显示提示框
-(void)showAlertView:(NSString *) alertTitle alertMsg:(NSString *)alertMsg alertTag:(int)alertTag {
//	[[GlobalValue getGlobalValueInstance] setHaveAlertViewInShow:YES];
    UIAlertView * alert;
    if (alertTag == ALERT_TAG_FORCEUPDATE_TRUE)
    {
        alert = [[OTSAlertView alloc]initWithTitle:alertTitle message:alertMsg delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil];
    }
    else if (alertTag == ALERT_TAG_FORCEUPDATE_FALSE)
    {
        alert = [[OTSAlertView alloc]initWithTitle:alertTitle message:alertMsg delegate:self cancelButtonTitle:@"稍后" otherButtonTitles:@"更新", nil];
    }
    else
    {
        alert = [[OTSAlertView alloc]initWithTitle:alertTitle message:alertMsg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    }
    alert.tag = alertTag;
	[alert show];
	[alert release];
	alert = nil;
}

@end
