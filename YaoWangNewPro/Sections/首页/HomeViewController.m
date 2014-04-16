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
    // Do any additional setup after loading the view from its nib.
}

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
        self.bigImageAdList = ((NSArray *)resultInfo.resultObject)[0];
        NSMutableArray *tempSmallAdList = ((NSArray *)resultInfo.resultObject)[1]; //这里是使用了iphone上的楼层数组
        for (AdFloorInfo *floor in tempSmallAdList)
        {
            for (SpecialRecommendInfo *product in floor.productList)
            {
                [self.smallImageAdList addObject:product];
            }
        }
        [self performSelectorOnMainThread:@selector(updateHomePage) withObject:nil waitUntilDone:YES];
    }
}










@end
