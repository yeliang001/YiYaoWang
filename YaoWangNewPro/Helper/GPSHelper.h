//
//  GPSHelper.h
//  YaoWang_iPadPro
//
//  Created by LinPan on 13-10-25.
//  Copyright (c) 2013年 LinPan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@protocol GPSHelperDelegate <NSObject>

@optional
- (void)didGPSHelperLocationingSucceed:(NSString *)province;
- (void)didGPSHelperLocationingFailed:(NSString *)error;

@end


@interface GPSHelper : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geoCoder;
}

@property (weak,nonatomic) id<GPSHelperDelegate> delegate;

+ (GPSHelper *)sharedInstance;
- (void)startLocationing;
- (void)stopLocationing;
@end
