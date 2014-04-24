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
#import "ImageCache.h"
#import "DataController.h"
#import "YWBaseService.h"
#import "YWSystemService.h"
#import "AdFloorInfo.h"
#import "OTSSearchView.h"

#define navHeight 49.0

#define ALERT_TAG_FORCEUPDATE_TRUE 101			// 强制更新
#define ALERT_TAG_FORCEUPDATE_FALSE 102			// 非强制更新
#define ALERT_TAG_APP_FIRST_LAUNCH 105
#define ALERT_TAG_APP_START_LAUNCH 106
#define ALERT_TAG_APP_WAKE  107


#define moduleTag 302

#define MODEAL_IMAGE_WIDTH  50
#define MODEAL_IMAGE_HEIGHT 50

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize modelATable;

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
    
    //搜索   // 叶亮：加入搜索栏
//	OTSSearchView *searchView=[[OTSSearchView alloc] initWithFrame:CGRectMake(0, yValue, 320, 40) delegate:m_Search];
//    [self.view addSubview:searchView];
//    [searchView release];
//    yValue+=40.0;
    
    //扫描
//    [self removeSubControllerClass:[Scan class]];
//    Scan *scan=[[[Scan alloc] initWithNibName:@"Scan" bundle:nil] autorelease];
//    [self pushVC:scan animated:NO];
    
    //page view
    CGFloat yValueInScroll=0.0;
    m_PageView=[[OTSPageView alloc] initWithFrame:CGRectMake(0, yValueInScroll, 320, 120) delegate:self showStatusBar:YES sleepTime:5];
    [m_ScrollView addSubview:m_PageView];
    
    // 功能模块
    [self initFunctionModules];
    
    // 广告模块
    if (m_AdArray!=nil&&m_AdArray.count>0) {
        [self updateCMSModuleA];
    }    
}

-(void)initFunctionModules
{
    CGFloat yValueInScroll=120.0;
    UIView *moduleView=[[UIView alloc] initWithFrame:CGRectMake(0, yValueInScroll, 320, 100)];
    moduleView.tag=moduleTag;
    [m_ScrollView addSubview:moduleView];
    [moduleView release];
    
    CGFloat xValue=7.0;
    CGFloat yValue=18.0;
    int i;
    for (i=0; i<5; i++)
    {
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(xValue, yValue, MODEAL_IMAGE_WIDTH, MODEAL_IMAGE_HEIGHT)];
        [button setTag:100+i];
        NSString *moduleName = nil;
        UIImage *image = nil;
        switch (i)
        {
            case 0:
                moduleName = @"当季热销";
                image = [UIImage imageNamed:@"icon_home_recommend.png"];
                break;
            case 1:
                moduleName = @"对症找药";
                image = [UIImage imageNamed:@"icon_home_gruop.png"];
                break;
            case 2:
                moduleName=@"我的收藏";
                image=[UIImage imageNamed:@"icon_home_favorite.png"];
                break;
            case 3:
                moduleName=@"浏览历史";
                image=[UIImage imageNamed:@"icon_home_browsehistory.png"];
                break;
            case 4:
                moduleName=@"物流跟踪";
                image=[UIImage imageNamed:@"icon_home_tracker.png"];
                break;
            default:
                break;
        }
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moduleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [moduleView addSubview:button];
        [button release];
        
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(xValue-13, yValue+50, MODEAL_IMAGE_WIDTH+26, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:moduleName];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [moduleView addSubview:label];
        [label release];
        
        
        xValue+=64.0;
    
        
    }
    modelATable=[[UITableView alloc]initWithFrame:CGRectMake(0, yValueInScroll+100, 320, 750) style:UITableViewStylePlain];
    modelATable.delegate=self;
    modelATable.dataSource=self;
    [m_ScrollView addSubview:modelATable];
    modelATable.scrollEnabled=NO;
    
    moduleView.frame=CGRectMake(0, 120, 320, 100);
    modelATable.frame=CGRectMake(0, 120/*+200*/, 320, 750); //这里控制高度是没有用，去这里改：adjustModulesHeight
}

//点击模块
-(void)moduleBtnClicked:(id)sender
{
    UIButton *  button=(UIButton*)sender;
    int index=[button tag]-100;
    switch (index)
    {
            
        case 0:
        {
            //历史记录
//            [self removeSubControllerClass:[MyBrowse class]];
//            MyBrowse *browse=[[[MyBrowse alloc]initWithNibName:@"MyBrowse" bundle:nil] autorelease];
//            [self pushVC:browse animated:YES];
            break;
        }
        case 1:
        {
            //团购
            //            [self enterIntoGroupList];
            
            break;
        }
            
        case 2:
        {
            //扫描
            //            [self removeSubControllerClass:[Scan class]];
            //            Scan *scan=[[[Scan alloc] initWithNibName:@"Scan" bundle:nil] autorelease];
            //            [self pushVC:scan animated:NO];
            break;
        }
        case 3:
        {
            //物流查询
//            [self enterLogisticQuery];
            break;
        }
        case 4:
        {
            //扫描
            //            [self removeSubControllerClass:[Scan class]];
            //            Scan *scan=[[[Scan alloc] initWithNibName:@"Scan" bundle:nil] autorelease];
            //            [self pushVC:scan animated:NO];
            break;
        }
        
            
        default:
            break;
    }
}

-(void)setUpNewThread{
    //获取热销图
    [self otsDetatchMemorySafeNewThreadSelector:@selector(newThreadGetHotPage) toTarget:self withObject:nil];
    [self otsDetatchMemorySafeNewThreadSelector:@selector(newThreadGetAdultConfig) toTarget:self withObject:nil];
    //是否需要版本更新
    [self otsDetatchMemorySafeNewThreadSelector:@selector(newThreadVersionUpdate) toTarget:self withObject:nil];
    //自动登录
    if ([[[UserManageTool sharedInstance] GetAutoLoginStatus] isEqualToString:@"1"])
    {
        /*暂停-叶亮*/
//        [self otsDetatchMemorySafeNewThreadSelector:@selector(newThreadAutoLogin) toTarget:self withObject:nil];
    }
}

//成人用品分类的配置
- (void)newThreadGetAdultConfig
{
    YWSystemService *ser = [[YWSystemService alloc] init];
    [GlobalValue getGlobalValueInstance].bShowAdultCategory = [ser isShowAdultCategory];
}

#pragma mark 版本更新
//获得版本更新数据
-(void)newThreadVersionUpdate {
//	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
//	YWSystemService * sServ = [[YWSystemService alloc]init] ;
//	@try {
//        VersionInfo *version = [sServ checkVersion];
//        /*暂停-叶亮*/
////        [self performSelectorOnMainThread:@selector(doVersionUpdate:) withObject:version waitUntilDone:NO];
//	}
//	@catch (NSException * e) {
//	}
//	@finally {
//        //         [sServ release];
//		[pool drain];
//	}
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
    if (index>=[[hotTopFivePage.resultObject objectAtIndex:0] count])
    {
        return;
    }
    
    
    SpecialRecommendInfo *recommendInfo = [[hotTopFivePage.resultObject objectAtIndex:0] objectAtIndex:index];
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
    if (i>=[[hotTopFivePage.resultObject objectAtIndex:0] count]) {
        imageView.image = [UIImage imageNamed:@"defaultimg320x120.png"];
    }
    else
    {
        
        //用于药店修改 Linpan
        //        NSString *fileName=[((HotPointNewVO *)[hotTopFivePage.objList objectAtIndex:i]).picUrl stringFromMD5];
        //        UIImage *image=[ImageCache getImageFromFile:fileName];
        
        NSString *fileName=[((SpecialRecommendInfo *)[[hotTopFivePage.resultObject objectAtIndex:0] objectAtIndex:i]).imageUrl stringFromMD5];
        UIImage *image=[ImageCache getImageFromFile:fileName];
        if (image != nil) {
            imageView.image = image;
        } else {
            imageView.image = [UIImage imageNamed:@"defaultimg320x120.png"];
        }
    }
    return imageView;
}


- (NSInteger)numberOfPagesInPageView:(OTSPageView *)pageView {
    if (hotTopFivePage==nil || [hotTopFivePage.resultObject objectAtIndex:0]==nil)
    {
        return 1;
    }
    return [[hotTopFivePage.resultObject objectAtIndex:0] count];
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

#pragma mark - refreshHomePageData
//刷新首页数据
-(void)refreshHomePageData
{
    //刷新热销图
    if (!isRefreshingHotPage && !isRefreshingAd) {
        isRefreshingHotPage=YES;
        isRefreshingAd = YES;
        [self otsDetatchMemorySafeNewThreadSelector:@selector(newThreadGetHotPage) toTarget:self withObject:nil];
    }
}

//下拉刷新停止
-(void)stopEgoRefresh
{
    if (!isRefreshingHotPage && !isRefreshingAd) {
        [m_RefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:m_ScrollView];
    }
}


#pragma mark - 热销图
//***** 轮播图 ************
-(void)newThreadGetHotPage {
    DebugLog(@"test520 自动登陆 newThreadGetHotPage");
    
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    
    //Linpan
    YWProductService *productSer = [[YWProductService alloc] init];
    ResultInfo *tempPage = [productSer getHomeSpcecialList];
    isRefreshingHotPage=NO;
    
    isRefreshingAd = NO;
    
    
    if (tempPage!=nil && ![tempPage isKindOfClass:[NSNull class]])
    {
        if (hotTopFivePage!=nil)
        {
            [hotTopFivePage release];
        }
        hotTopFivePage=[tempPage retain];
        for (int i=0; i<[[hotTopFivePage.resultObject objectAtIndex:0] count]; i++)
        {
            NSString *fileName;
            NSString *hotProductImgUrlStr=((SpecialRecommendInfo *)[[hotTopFivePage.resultObject objectAtIndex:0] objectAtIndex:i]).imageUrl;
            if (hotProductImgUrlStr==nil)
            {
                continue;
            }
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:hotProductImgUrlStr]];
            fileName=[hotProductImgUrlStr stringFromMD5];
            
            [DataController writeApplicationData:data name:fileName];
            [self savePagesToLocal:hotTopFivePage];
        }
        
        //楼层广告
        m_AdArray = [[hotTopFivePage.resultObject objectAtIndex:1] retain];
        [self performSelectorOnMainThread:@selector(updateHotPage) withObject:nil waitUntilDone:YES];
        
    }
    [self performSelectorOnMainThread:@selector(stopEgoRefresh) withObject:nil waitUntilDone:NO];
    
    
    [productSer release];
    
	[pool drain];
}

//刷新热销图
-(void)updateHotPage
{
    [self.view setUserInteractionEnabled:YES];
    [m_PageView reloadPageView];
    
    //焦点图和楼层一起了
    [self updateCMSModuleA];
}

//刷新模块A列表
-(void)updateCMSModuleA
{
    UIView*moduleView=[m_ScrollView viewWithTag:moduleTag];
    CGFloat yValueInScroll=120+moduleView.frame.size.height;
    [modelATable reloadData];
    [self adjustModulesHeight];
    int  increace = m_AdArray.count;
    [m_ScrollView setContentSize:CGSizeMake(320, yValueInScroll+increace*(210.0-25.0))];
}

-(void)adjustModulesHeight{
    UIView*moduleView=[m_ScrollView viewWithTag:moduleTag];
    
    //8个模块被写死，所以不需要调整高度了－－－－ Linpan
    moduleView.frame=CGRectMake(0, 120, 320, 100);
    modelATable.frame=CGRectMake(0, 120+100, 320, 750*m_AdArray.count); //改为了4个模块，所以y ＝ 120 ＋ 100
}

-(void)savePagesToLocal:(ResultInfo*)resultInfo
{
    NSString *filename=[OTSUtility documentDirectoryWithFileName:@"SaveHotPages_130502.plist"];
    NSData* pageData = [NSKeyedArchiver archivedDataWithRootObject:resultInfo.resultObject];
    [pageData writeToFile:filename atomically:NO];
}

-(Page*)getPagesFromLocal
{
    NSString *filename=[OTSUtility documentDirectoryWithFileName:@"SaveHotPages_130502.plist"];
    Page* aPage = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    return aPage;
}

#pragma mark EGORefreshTableHeaderView相关delegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self refreshHomePageData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return isRefreshingHotPage;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return [NSDate date];
}

#pragma mark - tableView相关delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DebugLog(@" m_AdArray.count--> %d", m_AdArray.count);
    return m_AdArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210.00-25.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identify=@"cell";
    HomePageModelACell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil)
    {
        cell=[[[HomePageModelACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    cell.delegate=self;
    
    DebugLog(@"m_array -> %@",m_AdArray);
    AdFloorInfo *floor = m_AdArray[indexPath.row];
    if (floor && [floor isKindOfClass:[AdFloorInfo class]])
    {
        NSLog(@"floor.keywordList  %@   %@",floor.keywordList,floor.title);
        
        cell.keywordsArray = floor.keywordList;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.tag=indexPath.row;
        
        if (floor.productList.count >= 1)
        {
            SpecialRecommendInfo *product = floor.productList[0];
            [cell loadBigImg:product.imageUrl title:product.name subTitle:product.name];
        }
        
        if (floor.productList.count >= 2)
        {
            SpecialRecommendInfo *product1 = floor.productList[1];
            [cell loadFistImg:product1.imageUrl title:product1.name subTitle:product1.name];
        }
        
        if (floor.productList.count >= 3)
        {
            SpecialRecommendInfo *product2 = floor.productList[2];
            [cell loadsecondImg:product2.imageUrl title:product2.name subTitle:product2.name];
        }
        
        int style= 1;
        NSString* tit=floor.title;
        //        if (tit!=nil&&[tit isKindOfClass:[NSString class]]&&tit.length>0) {
        [cell freshCell:indexPath.row style:style title:tit];
        //        }
    }
    return cell;
}

#pragma mark tableview 新的model A
-(void)keywordBtnSelceted:(UIButton*)button type:(int)type{
   /*叶亮*/
    
//    NSString *keyword=[button titleForState:UIControlStateNormal];
//    if (keyword!=nil)
//    {
//        SearchResult *searchResult=[[[SearchResult alloc] initWithKeyword:keyword fromTag:FROM_AD_MODEL] autorelease];
//        [self pushVC:searchResult animated:YES];
//    }
}

#pragma mark - 楼层图片点击事件入口
-(void)promotionTapcell:(HomePageModelACell*)cell withIdenty:(int)tag
{
    /*叶亮*/
//    AdFloorInfo *floor = [OTSUtility safeObjectAtIndex:cell.tag inArray:m_AdArray];
//    if (floor == nil)
//    {
//        return;
//    }
//    
//    SpecialRecommendInfo *specialRecommentInfo = floor.productList[tag];
//    if (specialRecommentInfo.type == kYaoSpecialProduct)
//    {
//        //进入商品页面
//        [self enterIntoProductView:specialRecommentInfo.productId];
//    }
//    else if (specialRecommentInfo.type == kYaoSpecialBrand)
//    {
//        //品牌页面
//        [self showAlertView:@"" alertMsg:@"暂无品牌页面" alertTag:12312];
//        
//    }
//    else if (specialRecommentInfo.type == kYaoSpecialCatagory)
//    {
//        [self enterIntoCategoryList:specialRecommentInfo.catalogId];
//    }
}

#pragma mark    取消加载view
-(void)releaseResource
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    OTS_SAFE_RELEASE(m_ScrollView);
    OTS_SAFE_RELEASE(hotTopFivePage);
    OTS_SAFE_RELEASE(m_RefreshHeaderView);
    OTS_SAFE_RELEASE(m_PageView);
}
-(void)viewDidUnload
{
	[self releaseResource];
    [super viewDidUnload];
}
- (void)dealloc {
	[self releaseResource];
    OTS_SAFE_RELEASE(m_AdArray);
    OTS_SAFE_RELEASE(modelATable);
    [super dealloc];
}

@end
