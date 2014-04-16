//
//  UtilsMacro.h
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-19.
//  Copyright (c) 2014年 林盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilsMacro : NSObject


/////////////////////////////////LOG DEFINE BEGIN///////////////////////////////
#ifdef DEBUG

#define DebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DebugLog(...)
#endif


@end
