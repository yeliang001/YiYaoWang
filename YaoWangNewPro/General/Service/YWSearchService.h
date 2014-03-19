//
//  YWSearchService.h
//  TheStoreApp
//
//  Created by LinPan on 13-8-5.
//
//

#import "YWBaseService.h"

@class SearchResultInfo;
@interface YWSearchService : YWBaseService

- (SearchResultInfo *)getSearchProductListWithParam:(NSDictionary *)paramDic;
- (NSMutableArray *)getSearchKeyword:(NSDictionary *)paramDic;
@end
