//
//  Config.h
//  YaoWang_iPadPro
//
//  Created by LinPan on 13-10-22.
//  Copyright (c) 2013年 LinPan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;
#define kYao_TRANS_DURATION  0.2f//页面转换渐变时间
#define kYaoViewWidth 1024
#define kYaoViewHeight 768

#define kYaoSavedUsername @"username"
#define KYaoSaveAccountService @"SaveAccountService"
#define kYaoRemeberPassword @"remeberPsw"
#define kYaoAutoLogin @"AutoLogin"


@interface Config : NSObject
{
    
}

@property (copy, nonatomic) NSString * username;
@property (copy, nonatomic) NSString * userId;
@property (copy, nonatomic) NSString * token;
@property (strong, nonatomic) UserInfo *userInfo; //保存当前登入的userinfo
@property (copy, nonatomic) NSString * provinceId; //当前的省份
@property (copy, nonatomic) NSString * provinceName;
@property (assign, nonatomic) BOOL bAutoLogin; //是不是自动登录

@property (strong, nonatomic) NSMutableArray * cartProductList; //把购物车的商品列表保存一份在内存
@property (assign, nonatomic) CGFloat cartTotalMoney;//购物车总价
@property (assign, nonatomic) int cartTotalCount;//总的商品数
@property (assign, nonatomic) NSInteger currentRepertory;

@property (assign, nonatomic) NSInteger hostIndex; //服务器编号，0 = 生产 


+ (Config *)defaultConfig;

- (void)saveCurrentProvince;

- (void)saveCurrentUsername:(NSString *)username;
- (void)saveCurrentPsw:(NSString *)psw;
- (NSString *)getLastUsername;
- (NSString *)getLastPsw;

- (void)remeberPassword:(BOOL)isRemember;
- (BOOL)bRememberPassword;



- (void)testAlert;
@end
