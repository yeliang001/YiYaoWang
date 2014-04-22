//
//  AppMacro.h
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-19.
//  Copyright (c) 2014年 林盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppMacro : NSObject

#define SharedPadDelegate   ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kURLScheme @"yhyw_iphone"

//ios7
#define ISIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

// RELEASE AND SET NIL
#define OTS_SAFE_RELEASE(_obj) if ((_obj)) {[(_obj) release]; (_obj) = nil;}

//Address
#define kYaoDefaultProvinceName @"上海市"
#define kYaoSavedProvinceId @"kYaoSavedProvinceId"
#define kYaoSavedProvinceName @"kYaoSavedProvinceName"

//search sort
#define SORT_BY_DEFAULT 0    //对应默认排序
#define SORT_BY_TIME 1       //最新发布
#define SORT_BY_PRICE_ASC 2  //价格最低
#define SORT_BY_PRICE_DESC 5 //价格最高  特殊处理，上传给服务器时要改为2 fuck
#define SORT_BY_COMMENT_DESC 3 //好评最高
#define SORT_BY_SALE  4        //销量最高

//Screen
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ApplicationHeight [UIScreen mainScreen].applicationFrame.size.height
#define ApplicationWidth [UIScreen mainScreen].applicationFrame.size.width

//



//发票抬头类型
typedef enum
{
    kYaoInvoiceHeadPerson = 0, //个人
    kYaoInvoiceHeadCompany = 1, //单位
}kYaoInvoiceHeadType;

//发票类型
typedef enum
{
    kYaoInvoiceCommercial = 0, //普通发票
    kYaoInvoiceVAT = 1, //增值税发票
    kYaoInvoiceNone = 3 //不开发票
}kYaoInvoiceType;

//支付方式
typedef enum
{
    kYaoPaymentReachPay = 0, //货到付款
    kYaoPaymentAlipay = 1,   //支付宝客户端
    kYaoPaymentPosPay = 2    //货到刷卡
}kYaoPaymentType;

//商品列表页的类型
typedef enum
{
    //类型，0 默认列表(分类) 1，搜索列表 2，促销精选 3,首页轮播促销 4,浏览历史
    kYaoProductListViewTypeCategory = 0
    , kYaoProductListViewTypeSearch
    , kYaoProductListViewTypePromotion
    , kYaoProductListViewTypePage
    , kYaoProductListViewTypeHistory
    , kYaoProductListViewTypeCoupon
    , kYaoProductListViewTypeOrderProducts
    
}kYaoProductListViewType;


//促销类型
typedef enum
{
    // 满减 */
    kYaoPromotion_MJ = 1,
    /** 满返 */
    kYaoPromotion_MF = 2,
    /** 满赠 **/
    kYaoPromotion_MZ = 3,
    /** 换购 **/
    kYaoPromotion_HG = 4,
    /** 满额包邮 **/
    kYaoPromotion_BY = 5,
    /** 满额减 */
    kYaoPromotion_MEJ = 11,
    /** 满件减 */
    kYaoPromotion_MJJ = 12,
    /** 每满额减 */
    kYaoPromotion_MMEJ = 13,
    /** 每满件减 */
    kYaoPromotion_MMJJ = 14,
    /** 满额返 */
    kYaoPromotion_MEF = 21,
    /** 满件返 */
    kYaoPromotion_MJF = 22,
    /** 每满额返 */
    kYaoPromotion_MMEF = 23,
    /** 满额赠 **/
    kYaoPromotion_MEZ = 31,
    /** 满件赠 **/
    kYaoPromotion_MJZ = 32,
    /** 换购 **/
    kYaoPromotion_HG_ALL = 41,
    kYaoPromotion_HG_SPEC = 42
    
}kYaoPromotionType;


@end
