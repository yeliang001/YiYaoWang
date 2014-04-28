//
//  search.m
//  yihaodian
//  Created by lixiang on 10-12-17.
//  updatad by tianjsh on 11-04-14  添加释放池
//  Updated by tianjsh on 11-05-10  "暂时缺货"改为"已售完"
//  Updated by yangxd  on 11-07-05  修改购买方式
//  Copyright 2010 vsc. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "Search.h"
//#import "Trader.h"
//#import "Page.h"
//#import "SearchService.h"
//#import "UserManage.h"
//#import "Page.h"
//#import "GlobalValue.h"
//#import "CartService.h"
//#import "ProductVO.h"
//#import "FavoriteService.h"
//#import "NSData+Base64.h"
//#import "ShareToMicroBlog.h"
//#import "LocalCartItemVO.h"
//#import "ErrorStrings.h"
//#import "AlertView.h"
//#import "DataController.h"
//#import "SearchKeywordVO.h"
//#import "Scan.h"
//#import "DoTracking.h"
//#import "TheStoreAppAppDelegate.h"
//#import "OTSAlertView.h"
//#import "SearchCategoryVO.h"
//#import "SearchResult.h"
//#import "OTSServiceHelper.h"
//#import "YWSearchService.h"
//#import "RelationWordInfo.h"

#define THREAD_STATE_ADD_CART  1      //加入购物车
#define PROdUCT_DETAIL 3      //查看详情
#define THREAD_STATE_GET_ALL_PRODUCTS   14     //加载更多

#define PRODUCT_FROM_SEARCH 100
#define PRODUCT_FROM_FILTER 200

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SEARCHRESULT_ADD_TO_CART 0			// 添加到购物车
#define SEARCHRESULT_ADD_TO_FAVORITE 1		// 添加到收藏
#define SEARCHRESULT_SHARE_BLOG 2			// 分享新浪微博
#define SEARCHRESULT_SHARE_SMS 3			// 短信转发
#define SEARCHRESULT_GOTO_PRODUCTDETAIL 4	// 查看商品详情
#define SINA_USER_NAME_TAG 1
#define SINA_PASSWORD_TAG 2

#define ALERTVIEW_TAG_DELETE_CONFIRM 1
#define LOADMORE_HEIGHT 40

#define SORT_BY_DEFAULT 0
#define SORT_BY_RELATIONSHIP 1
//#define SORT_BY_SALE 2
//#define SORT_BY_PRICE_ASC 3
//#define SORT_BY_PRICE_DESC 4
//#define SORT_BY_COMMENT_DESC 5
//#define SORT_BY_TIME 6

#define GOODS_TAG 100
#define MARKET_PRICE_TAG 105
#define PRICE_TAG 101
#define HAVE_GOODS_TAG 102
#define BUTTON_TAG 103
#define DEFAULT_IMAGE_TAG 104
#define SHOPPING_COUNT_TAG 109

#define FLAG_CATEGORY   1
#define FLAG_SORT       2

//@synthesize listData;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
@interface Search()

-(void)initSearchHistory;
-(void)closeSearchHistoryAndRelationView;
@end

@implementation Search

@synthesize m_HomePageSearchBar;
@synthesize m_HomePageSearchBarCancelBtn;

-(id)init
{
    self=[super init];
    if (self!=nil) {
        [UIView setAnimationsEnabled:NO];
        [self initSearchHistory];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSearchHistoryAndRelationView) name:@"closeSearchHistoryAndRelationView" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFirstResponderFromHomepage) name:@"ResignFirstResponderFromHomepage" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchHistoryChanged:) name:@"SearchHistoryChanged" object:nil];
    }
    return self;
}

//搜索历史改变
-(void)searchHistoryChanged:(NSNotification *)notification
{
//    [self initSearchHistory];
//    [m_SearchHistoryTableView reloadData];
}

#pragma mark - 搜索历史
-(void)initSearchHistory
{
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//	NSString *filename=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"SearchHistory.plist"];
//	NSMutableArray *mArray=[[NSMutableArray alloc] initWithContentsOfFile:filename];
//    if (m_SearchHistoryArray!=nil) {
//        [m_SearchHistoryArray release];
//    }
//    if (mArray!=nil && [mArray count]!=0) {
//        m_SearchHistoryArray=[[NSMutableArray alloc] initWithArray:mArray];
//    } else {
//        m_SearchHistoryArray=[[NSMutableArray alloc] init];
//    }
//    [mArray release];
}

-(void)clearAllHistory:(id)sender
{
//    UIAlertView *alert=[[OTSAlertView alloc]initWithTitle:nil message:@"确定要清空历史记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//    [alert setTag:ALERTVIEW_TAG_DELETE_CONFIRM];
//    [alert show];
//    [alert release];
}

-(void)saveSearchKeyword
{
//    NSString *keyWord=[[NSString alloc] initWithString:m_KeyWord];
//    int i;
//    for (i=0;i<[m_SearchHistoryArray count];i++) {
//        NSString *text=[m_SearchHistoryArray objectAtIndex:i];
//        if ([text isEqualToString:keyWord]) {
//            [m_SearchHistoryArray removeObject:text];
//        }
//    }
//    [m_SearchHistoryArray insertObject:keyWord atIndex:0];
//    [keyWord release];
//    [m_SearchHistoryTableView reloadData];
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *filename=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"SearchHistory.plist"];
//    [m_SearchHistoryArray writeToFile:filename atomically:NO];
}

-(void)clearSearchHistory
{
//    if (m_SearchHistoryArray!=nil) {
//        [m_SearchHistoryArray removeAllObjects];
//    }
//    [m_SearchHistoryTableView reloadData];
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *filename=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"SearchHistory.plist"];
//    [m_SearchHistoryArray writeToFile:filename atomically:NO];
//	
//	[m_HomePageSearchBar resignFirstResponder];
//    
//    [self closeSearchHistoryAndRelationView];
}

-(void)closeSearchHistoryAndRelationView
{
//    if ([m_SearchHistoryView superview]!=nil) {
//        [m_SearchHistoryView removeFromSuperview];
//    }
//    if ([m_SearchRelationTableView superview]!=nil) {
//        [m_SearchRelationTableView removeFromSuperview];
//    }
//    [m_HomePageSearchBar setFrame:CGRectMake(0, 0, 320, 40)];
//    [m_HomePageSearchBarCancelBtn setHidden:YES];
}

-(IBAction)blackBtnClicked:(id)sender
{
//    [m_HomePageSearchBar resignFirstResponder];
//    [self closeSearchHistoryAndRelationView];
}

#pragma mark - 首页搜索
-(void)homePageCancelBtnClicked
{
//    [m_HomePageSearchBar setFrame:CGRectMake(0, 0, 320, 40)];
//    [m_HomePageSearchBarCancelBtn setHidden:YES];
//    [m_HomePageSearchBar resignFirstResponder];
//    [self closeSearchHistoryAndRelationView];
}

-(void)resignFirstResponderFromHomepage
{
//	[m_HomePageSearchBar resignFirstResponder];
//    [self closeSearchHistoryAndRelationView];
}

#pragma mark - 关键字
//新线程获取相关关键字
-(void)getRelationKeyWord:(NSString *)word
{
//	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
//    
//    
//    YWSearchService *searchSer = [[YWSearchService alloc] init];
//    NSDictionary *paramDic = @{@"word" : word,@"minScore":@"1",@"count":@"10"};
//    NSArray *tempArray = [searchSer getSearchKeyword:paramDic];
//    
//    getKeyWordRuning=NO;
//    if (m_SearchRelationArray!=nil)
//    {
//        [m_SearchRelationArray release];
//    }
//    if (tempArray==nil || [tempArray isKindOfClass:[NSNull class]])
//    {
//		m_SearchRelationArray = nil;
//    }
//    else
//    {
//        m_SearchRelationArray=[tempArray retain];
//    }
//	[self performSelectorOnMainThread:@selector(updateRelationTableView) withObject:nil waitUntilDone:NO];
//	[pool drain];
}

//刷新相关关键字显示
-(void)updateRelationTableView
{
	[m_SearchRelationTableView reloadData];
}

#pragma mark - 搜索结果
//显示搜索结果
-(void)enterSearchResultView
{
//    if (m_KeyWord!=nil) {
//        SearchResult *searchResult=[[[SearchResult alloc] initWithKeyword:m_KeyWord fromTag:FROM_HOMEPAGE] autorelease];
//        [[SharedDelegate homePage] pushVC:searchResult animated:YES];
//    }
}

-(void)showSearchView:(UISearchBar *)searchBar keyword:(NSString *)keyword
{
//    if ([keyword length]>0) {
//        if ([m_defaultHistoryView superview]!=nil) {
//            [m_defaultHistoryView removeFromSuperview];
//        }
//        if ([m_SearchHistoryView superview]!=nil) {
//            [m_SearchHistoryView removeFromSuperview];
//        }
//        if ([m_SearchRelationTableView superview]==nil) {
//            if (searchBar==m_HomePageSearchBar) {
//                [[SharedDelegate homePage].view addSubview:m_SearchRelationTableView];
//                [m_SearchRelationTableView setFrame:CGRectMake(0, 84, 320, [SharedDelegate homePage].view.frame.size.height-84)];
//            }
//        }
//		if (![[keyword substringWithRange:NSMakeRange(0, 1)] isEqualToString:@" "] && !getKeyWordRuning) {
//			getKeyWordRuning=YES;
//			[self otsDetatchMemorySafeNewThreadSelector:@selector(getRelationKeyWord:) toTarget:self withObject:keyword];
//		}
//	} else {
//        if ([m_defaultHistoryView superview]!=nil) {
//            [m_defaultHistoryView removeFromSuperview];
//        }
//        if ([m_SearchHistoryView superview]!=nil) {
//            [m_SearchHistoryView removeFromSuperview];
//        }
//        if (m_SearchHistoryArray==nil || [m_SearchHistoryArray count]==0) {
//            if (searchBar==m_HomePageSearchBar) {
//                [[SharedDelegate homePage].view addSubview:m_defaultHistoryView];
//                [m_defaultHistoryView setFrame:CGRectMake(0, 84, 320, [SharedDelegate homePage].view.frame.size.height-84)];
//            }
//        } else {
//            if (searchBar==m_HomePageSearchBar) {
//                [[SharedDelegate homePage].view addSubview:m_SearchHistoryView];
//                [m_SearchHistoryView setFrame:CGRectMake(0, 84, 320, [SharedDelegate homePage].view.frame.size.height-84)];
//            }
//            [m_SearchHistoryTableView setFrame:CGRectMake(0, 40, 320, [SharedDelegate homePage].view.frame.size.height-124)];
//        }
//        
//        if ([m_SearchRelationTableView superview]!=nil) {
//            [m_SearchRelationTableView removeFromSuperview];
//        }
//        if (m_SearchRelationArray!=nil) {
//            [m_SearchRelationArray release];
//        }
//		m_SearchRelationArray=nil;
//		[m_SearchRelationTableView reloadData];
//	}
}

#pragma mark searchBar相关delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    if (searchBar==m_HomePageSearchBar) {
//        [m_HomePageSearchBarCancelBtn setHidden:NO];
//        [m_HomePageSearchBar setFrame:CGRectMake(0, 0, 272, 40)];
//    }
//    if ([m_SearchRelationTableView superview] == nil) {
//        [self showSearchView:searchBar keyword:[searchBar text]];
//    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
//    [m_defaultHistoryView removeFromSuperview];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    if (m_KeyWord!=nil) {
//        [m_KeyWord release];
//    }
//    m_KeyWord=[searchText retain];
//    [self showSearchView:searchBar keyword:m_KeyWord];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    if (m_KeyWord!=nil) {
//        [m_KeyWord release];
//    }
//	m_KeyWord=[[searchBar text] retain];
//
//    //[searchBar resignFirstResponder];
//    [self blackBtnClicked:nil];
//    if (!m_KeyWord || [[m_KeyWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<1) {
//        [AlertView showAlertView:nil alertMsg:@"搜索字段为空，请重新输入" buttonTitles:nil alertTag:ALERTVIEW_TAG_COMMON];
//        [self closeSearchHistoryAndRelationView];
//    } else {
//        [self saveSearchKeyword];
//        [self enterSearchResultView];
//    }
}

#pragma mark tableView相关delegate和dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self blackBtnClicked:nil];
//    
//	if (tableView==m_SearchRelationTableView) {//关联关键字
//		if ([m_SearchRelationArray count] != 0) {
//			if (m_KeyWord!=nil) {
//				[m_KeyWord release];
//			}
//			RelationWordInfo *keyWordVO=[OTSUtility safeObjectAtIndex:[indexPath row] inArray:m_SearchRelationArray];
//			m_KeyWord = [[keyWordVO relationWord] retain];
//            
//            [self saveSearchKeyword];
//			[self enterSearchResultView];
//            
//            //会修改keyword，进入search result之后调用
//            [m_HomePageSearchBar resignFirstResponder];
//            [m_HomePageSearchBar setText:m_KeyWord];
//		}
//    } else if (tableView==m_SearchHistoryTableView) {//历史列表
//        if ([indexPath row]<[m_SearchHistoryArray count]) {
//            if (m_KeyWord!=nil) {
//                [m_KeyWord release];
//            }
//            m_KeyWord = [[OTSUtility safeObjectAtIndex:[indexPath row] inArray:m_SearchHistoryArray] retain];
//            
//            [self saveSearchKeyword];
//            [self enterSearchResultView];
//            
//            //会修改keyword，进入search result之后调用
//            [m_HomePageSearchBar resignFirstResponder];
//            [m_HomePageSearchBar setText:m_KeyWord];
//        }
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//	if (tableView==m_SearchRelationTableView)
//    {
//		if ([m_SearchRelationArray count] == 0) {
//			return 1;
//		}else {
//			return [m_SearchRelationArray count];
//		}
//    } else if (tableView==m_SearchHistoryTableView) {
//        return [m_SearchHistoryArray count]+1;
//    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//	[UIView setAnimationsEnabled:NO];
//	if (tableView==m_SearchRelationTableView)
//    {
//        //关联关键字列表
//		UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SearchRelationCell"];
//		if (cell==nil)
//        {
//			cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SearchRelationCell"] autorelease];
//            [cell setBackgroundColor:[UIColor whiteColor]];
//		}
//		if ([m_SearchRelationArray count] == 0)
//        {
//			if ([indexPath row] == 0) {
//				[[cell textLabel] setText:@"无结果"];
//				[[cell textLabel] setFont:[UIFont systemFontOfSize:15.0]];
//				[[cell detailTextLabel] setText:@""];
//			}
//		}
//        else
//        {
//			RelationWordInfo *keyWordVO=[OTSUtility safeObjectAtIndex:[indexPath row] inArray:m_SearchRelationArray];
//			[[cell textLabel] setText:[keyWordVO relationWord]];
//			[[cell textLabel] setFont:[UIFont systemFontOfSize:15.0]];
//		}
//		return cell;
//	} else if (tableView==m_SearchHistoryTableView) {//历史列表
//		UITableViewCell *cell;
//		if ([indexPath row]<[m_SearchHistoryArray count]) {
//			cell=[tableView dequeueReusableCellWithIdentifier:@"SearchHistoryCell"];
//            if (cell==nil) {
//                cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchHistoryCell"] autorelease];
//                [cell setBackgroundColor:[UIColor whiteColor]];
//            }
//            [[cell textLabel] setText:[OTSUtility safeObjectAtIndex:[indexPath row] inArray:m_SearchHistoryArray]];
//			[[cell textLabel] setFont:[UIFont systemFontOfSize:15.0]];
//		} else {
//            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
//            [cell setBackgroundColor:[UIColor whiteColor]];
//            UIButton *clearBtn=[[UIButton alloc] initWithFrame:CGRectMake(105, 4, 110, 36)];
//            [clearBtn setBackgroundImage:[UIImage imageNamed:@"gray_btn.png"] forState:UIControlStateNormal];
//            [clearBtn setTitle:@"清空历史记录" forState:0];
//            [clearBtn setTag:100];
//            [clearBtn setTitleColor:[UIColor blackColor] forState:0];
//            [clearBtn addTarget:self action:@selector(clearAllHistory:) forControlEvents:UIControlEventTouchUpInside];
//            [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//            [cell addSubview:clearBtn];
//            [clearBtn release];
//        }
//		return cell;
//    } else {
//        UITableViewCell *cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
//        return cell;
//    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView==m_SearchHistoryTableView || scrollView==m_SearchRelationTableView) {
//        [m_HomePageSearchBar resignFirstResponder];
//    }
}

#pragma mark    alertView相关delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//	switch (alertView.tag) {
//        case ALERTVIEW_TAG_DELETE_CONFIRM: {
//            if (buttonIndex==1) {
//                [self clearSearchHistory];
//            }
//            break;
//        }
//		default:
//			break;
//	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
-(void)releaseMyResoures:(BOOL)memoryNotEnough
{
    if (!memoryNotEnough) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        OTS_SAFE_RELEASE(m_HomePageSearchBar);
        OTS_SAFE_RELEASE(m_HomePageSearchBarCancelBtn);
        OTS_SAFE_RELEASE(m_SearchHistoryArray);
    }
    
    OTS_SAFE_RELEASE(m_KeyWord);
    OTS_SAFE_RELEASE(m_SearchRelationArray);
    // release outlet
    OTS_SAFE_RELEASE(m_SearchRelationTableView);
    OTS_SAFE_RELEASE(m_BlackBtn);
    OTS_SAFE_RELEASE(m_SearchHistoryView);
    OTS_SAFE_RELEASE(m_SearchHistoryTableView);
    OTS_SAFE_RELEASE(m_ScanBtn);
    OTS_SAFE_RELEASE(m_defaultHistoryView);
    
	// remove vc
}

- (void)viewDidUnload
{
    [self releaseMyResoures:YES];
    [super viewDidUnload];
}

-(void)dealloc
{
    [self releaseMyResoures:NO];
    [super dealloc];
}

@end
