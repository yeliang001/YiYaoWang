//
//  OTSUtility.h
//  TheStoreApp
//
//  Created by yiming dong on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductVO;
@class BankVO;
@class OrderV2;
@class Page;

@interface OTSUtility : NSObject

// date
+(NSDate *)NSStringDateToNSDate:(NSString *)anString; //格式为 yyyy/MM/dd 的字符串转成NSDate
+(NSString *)NSDateToNSStringDate:(NSDate *)anDate;  //NSDate输出转成 yyyy/MM/dd HH:mm:ss
+(NSString *)NSDateToNSStringDateV2:(NSDate *)anDate; //NSDate输出转成 yyyy_MM_dd HH:mm:ss

//// rect
//+(void)logRect:(CGRect)aRect; 
//+(CGRect)modifyRect:(CGRect)aRect value:(float)aValue modifyType:(int)aType; //给定一个aValue，根据aType值，改变对应aRect的x/y/width/height
//
//// product
//+(UIImage*)miniImageForProduct:(ProductVO*)aProduct;
//+(BOOL)canBuyProduct:(ProductVO*)aProduct;
//+(UIImage*)getMiniImageWithProductId:(NSNumber*)aProductId;
//
//// UIView
//+(void)setShadowForView:(UIView*)aView;  // 设置视图的阴影
//+(void)setCornerRadius:(int)aCornerRadius borderColor:(UIColor*)aBorderColor forView:(UIView*)aView;
//+(void)horizontalCenterViews:(NSArray*)aViews inView:(UIView*)aSuperView margin:(NSUInteger)aMargin;
//
//// other
//+(id)safeObjectAtIndex:(int)aIndex inArray:(NSArray*)anArray; //返回数组anArray的第 aIndex 个元素
//+(void)callWithPhoneNumber:(NSString*)aPhoneNumber;
//+(NSString*)chineseForDigit:(int)aDigit;
+(NSString*)documentDirectoryWithFileName:(NSString*)name; //拿到document目录下name目录的路径
//
//// test
//+(void)testiPadInterface;
//
//// runtime data
//+(NSArray*)requestBanks;
//
//// return Signature
//+(NSString*)requestSignature:(NSNumber*)aOnlineorderid;
//+(NSString *)requestAliPaySignature:(NSNumber *)aOnlineorderid;
//
//+(void)alert:(NSString*)aMessage;
//+(void)alertWhenDebug:(NSString*)aMessage;
//+(void)showAlertView:(NSString *) alertTitle
//            alertMsg:(NSString *)alertMsg
//            alertTag:(int)tag;
//
//+(NSString*)timeStringFromInterval:(int)aInterval;
//+(BOOL)hasNetwork;
//
//+(void)threadRequestSaveGateWay:(BankVO*)aBankVO forOrder:(OrderV2*)anOrder;
//+(NSString*)getInterfaceNameFromSelector:(SEL)aSelector;
//
////缓存page
//+(void)putPagesToLocal:(Page*)aPage withPageName:(NSString *)name withKey:(NSString *)key;
//+(Page*)getPagesFromLocal:(NSString *)name withKey:(NSString *)key;

@end


enum _EOtsRectModifyType
{
    KOtsRectModifyX = 0
    , KOtsRectModifyY
    , KOtsRectModifyWidth
    , KOtsRectModifyHeight
};