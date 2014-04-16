//
//  GPSHelper.m
//  YaoWang_iPadPro
//
//  Created by LinPan on 13-10-25.
//  Copyright (c) 2013年 LinPan. All rights reserved.
//

#import "GPSHelper.h"
#import <CoreLocation/CoreLocation.h>

@implementation GPSHelper

static GPSHelper *sharedInstance = nil;

+ (GPSHelper *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.0f;
        
        
        _geoCoder = [[CLGeocoder alloc] init];
        
    }
    return self;
}


- (void)startLocationing
{
    //开始定位
    [_locationManager startUpdatingLocation];
}


- (void)stopLocationing
{
    [_locationManager stopUpdatingLocation];
    [_geoCoder cancelGeocode];
}

#pragma mark - CLLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    if (locations.count > 0)
    {
        for (CLLocation *location in locations)
        {
            DebugLog(@"location: %@",location);
        }
        
        // 获取当前所在的城市名
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray *array, NSError *error)
         {
             if (array.count > 0)
             {
                 CLPlacemark *placemark = [array objectAtIndex:0];
                 NSString *province = placemark.administrativeArea;
                 DebugLog(@"administrativeArea %@",province);
                 
                 if (_delegate && [_delegate respondsToSelector:@selector(didGPSHelperLocationingSucceed:)])
                 {
                     [_delegate didGPSHelperLocationingSucceed:[self convertProvinceFromEnglishToChinese:province]];
                 }
             }
             else if (error == nil && [array count] == 0)
             {
                 NSLog(@"No results were returned.");
                 if (_delegate && [_delegate respondsToSelector:@selector(didGPSHelperLocationingFailed:)])
                 {
                     [_delegate didGPSHelperLocationingFailed:nil];
                 }
             }
             else if (error != nil)
             {
                 NSLog(@"An error occurred = %@", error);
                 
                 if (_delegate && [_delegate respondsToSelector:@selector(didGPSHelperLocationingFailed:)])
                 {
                     [_delegate didGPSHelperLocationingFailed:error];
                 }
             }
             
             [self stopLocationing];
         }];
    }
    
       
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    DebugLog(@"Locationing failed");
    if (_delegate && [_delegate respondsToSelector:@selector(didGPSHelperLocationingFailed:)])
    {
        [_delegate didGPSHelperLocationingFailed:error];
    }
}


- (NSString*)convertProvinceFromEnglishToChinese:(NSString*)aProvinceName
{
    NSCharacterSet* characterSet= [NSCharacterSet uppercaseLetterCharacterSet];
    //    英文字符集，表示使用英文环境
    if ([aProvinceName rangeOfCharacterFromSet:characterSet].location!=NSNotFound)
    {
        if ([aProvinceName isEqualToString:@"Shanghai"])
        {
            aProvinceName= @"上海市";
        }
        else if ([aProvinceName  isEqualToString:@"Beijing"])
        {
            aProvinceName=  @"北京市";
        }
        else if([aProvinceName  isEqualToString:@"Tianjin"])
        {
            aProvinceName=  @"天津市";
        }
        else if ([aProvinceName isEqualToString:@"Hebei"])
        {
            aProvinceName=  @"河北省";
        }
        else if ([aProvinceName  isEqualToString:@"Jiangsu"])
        {
            aProvinceName=  @"江苏省";
        }
        else if ([aProvinceName  isEqualToString:@"Zhejiang"])
        {
            aProvinceName=  @"浙江省";
        }
        else if ([aProvinceName  isEqualToString:@"Chongqing"])
        {
            aProvinceName=  @"重庆市";
        }
        else if ([aProvinceName  isEqualToString:@"Neimenggu"])
        {
            aProvinceName=  @"内蒙古";
        }
        else if ([aProvinceName  isEqualToString:@"Liaoning"])
        {
            aProvinceName=  @"辽宁省";
        }
        else if ([aProvinceName  isEqualToString:@"Jilin"])
        {
            aProvinceName=  @"吉林省";
        }
        else if ([aProvinceName  isEqualToString:@"Heilongjiang"])
        {
            aProvinceName=  @"黑龙江省";
        }
        else if ([aProvinceName  isEqualToString:@"Sichuan"])
        {
            aProvinceName=  @"四川省";
        }
        else if ([aProvinceName  isEqualToString:@"Anhui"])
        {
            aProvinceName=  @"安徽省";
        }
        else if ([aProvinceName isEqualToString:@"Fujian"])
        {
            aProvinceName=  @"福建省";
        }
        else if ([aProvinceName  isEqualToString:@"Jiangxi"])
        {
            aProvinceName=  @"江西省";
        }
        else if ([aProvinceName  isEqualToString:@"Shandong"])
        {
            aProvinceName=  @"山东省";
        }
        else if ([aProvinceName  isEqualToString:@"Henan"]) {
            aProvinceName=  @"河南省";
        }
        else if ([aProvinceName  isEqualToString:@"Hubei"])
        {
            aProvinceName=  @"湖北省";
        }
        else if ([aProvinceName  isEqualToString:@"Hunan"])
        {
            aProvinceName=  @"湖南省";
        }
        else if ([aProvinceName  isEqualToString:@"Guangdong"])
        {
            aProvinceName=  @"广东省";
        }
        else if ([aProvinceName  isEqualToString:@"Guangxi"])
        {
            aProvinceName=  @"广西省";
        }
        else if ([aProvinceName  isEqualToString:@"Hainan"])
        {
            aProvinceName=  @"海南省";
        }
        else if ([aProvinceName  isEqualToString:@"Guizhou"])
        {
            aProvinceName=  @"贵州省";
        }
        else if ([aProvinceName  isEqualToString:@"Yunnan"])
        {
            aProvinceName=  @"云南省";
        }
        else if ([aProvinceName  isEqualToString:@"Xizang"])
        {
            aProvinceName=  @"西藏";
        }
        else if ([aProvinceName  isEqualToString:@"Shaanxi"])
        {
            aProvinceName=  @"陕西省";
        }
        else if ([aProvinceName  isEqualToString:@"Gansu"])
        {
            aProvinceName=  @"甘肃省";
        }
        else if ([aProvinceName isEqualToString:@"Qinghai"])
        {
            aProvinceName=  @"青海省";
        }
        else if ([aProvinceName isEqualToString:@"Xinjiang"])
        {
            aProvinceName=  @"新疆省";
        }
        else if ([aProvinceName isEqualToString:@"Ningxia"])
        {
            aProvinceName=  @"宁夏省";
        }
//        else if ([aProvinceName isEqualToString:@"Taiwan"])
//        {
//            aProvinceName=  @"台湾";
//        }
        else if ([aProvinceName isEqualToString:@"Shanxi"])
        {
            aProvinceName=  @"山西省";
        }
        else
        {
            aProvinceName=  @"上海市";
        }
    }
    
    return aProvinceName;
}


@end
