//
//  Config.m
//  YaoWang_iPadPro
//
//  Created by LinPan on 13-10-22.
//  Copyright (c) 2013年 LinPan. All rights reserved.
//

#import "Config.h"
#import "UserInfo.h"
#import "SFHFKeychainUtils.h"
#import "LocalCarInfo.h"
@implementation Config

- (id)init
{
    self = [super init];
    if (self)
    {
        _cartProductList = [[NSMutableArray alloc] init];
    }
    
    return self;
}


+ (Config *)defaultConfig
{
	static Config * instance;
	@synchronized(self)
    {
		if (instance==nil)
        {
			instance=[[Config alloc]init];
            
		}
		return instance;
	}
}

- (NSString *)token
{
    if (_userInfo)
    {
        return _userInfo.token;
    }
    
    return nil;
}


- (NSString *)userId
{
    if (_userInfo)
    {
        return _userInfo.ecUserId;
    }
    return nil;
}

- (NSString *)username
{
    if (_userInfo)
    {
        return _userInfo.uid;
    }
    return nil;
}


- (int)cartTotalCount
{
    NSInteger count = 0;
    
    for (LocalCarInfo * local in _cartProductList)
    {
        count += [local.num intValue];
    }
    
    return count;
}


- (CGFloat)cartTotalMoney
{
    CGFloat money = 0;
    
    for (LocalCarInfo * local in _cartProductList)
    {
        money += [local.price floatValue];
    }
    
    return money;
}


- (void)saveCurrentProvince
{
    [[NSUserDefaults standardUserDefaults] setObject:_provinceId forKey:kYaoSavedProvinceId];
    [[NSUserDefaults standardUserDefaults] setObject:_provinceName forKey:kYaoSavedProvinceName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveCurrentUsername:(NSString *)username
{
    if (username && username.length > 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:kYaoSavedUsername];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)getLastUsername
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kYaoSavedUsername];
}

- (void)saveCurrentPsw:(NSString *)psw
{
    [SFHFKeychainUtils storeUsername:[self getLastUsername] andPassword:psw forServiceName:KYaoSaveAccountService updateExisting:1 error:nil];
}

- (NSString *)getLastPsw
{
    return [SFHFKeychainUtils getPasswordForUsername:[self getLastUsername] andServiceName:KYaoSaveAccountService error:nil];
}

//设置是否自动登录
- (void)setBAutoLogin:(BOOL)bAutoLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:bAutoLogin forKey:kYaoAutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)bAutoLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kYaoAutoLogin];
}
//是不是保存密码
- (BOOL)bRememberPassword
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kYaoRemeberPassword];
}
//保存密码
- (void)remeberPassword:(BOOL)isRemember
{
    [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:kYaoRemeberPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSInteger)currentRepertory
{
    NSInteger repertory;
    switch ([_provinceId intValue])
    {
        case 2:case 3:case 4:case 32:case 8:case 9:case 10:case 11:case 16:case 17:case 26:case 27:case 28:case 29:case 30:
            repertory = 233900;
            break;
        case 1:case 5:case 6:case 13:
            repertory = 15;
            break;
        case 14:case 15:case 18:case 19:case 20: case 21:case 22:case 7:case 12:case 23:case 24:case 25:
            repertory = 13;
            break;
        default:
            repertory = 15;
            break;
    }
    
    return repertory;
}

@end
