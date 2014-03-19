//
//  YWProductService.h
//  TheStoreApp
//
//  Created by LinPan on 13-7-22.
//
//

#import "YWBaseService.h"
@class SpecialRecommendInfo;
@class Page;
@class ProductInfo;
@class CommentInfo;
@class CartInfo;
@interface YWProductService : YWBaseService

- (Page *)getHomeSpcecialList;
- (Page *)getCategory;

- (ProductInfo *)getProductDetail:(NSDictionary *)paramDic;
- (NSDictionary *)getProductCommentList:(NSDictionary *)paramDic;
- (NSMutableArray *)getProductInStock:(NSDictionary *)paramDic; //商品的库存商品返回数组

- (CartInfo *)getProductDetailList:(NSDictionary *)paramDic; //获取多个商品详细

@end
