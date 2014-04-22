//
//  HomePageModelACell.h
//  TheStoreApp
//
//  Created by yuan jun on 13-1-15.
//
//

#import <UIKit/UIKit.h>
#import "AdvertisingPromotionVO.h"
@protocol HomePageModelACellDelegate;
@interface HomePageModelACell : UITableViewCell
{
    UIImageView *titleImageView;
    UIImageView* headImgView;
    UIImageView*adBg;
    NSArray* keywordsArray;
    NSMutableArray* keywordBtns;
    UIImageView* bigImg,*firstImg,*secImg;
    UIView* promotionImg;
    UILabel* advTitle,*firstTit,*firstSubTit,*secTit,*secSubTit;//,*bigTitle,*bigSubTit;
    id <HomePageModelACellDelegate>delegate;
}
@property(nonatomic,assign)id <HomePageModelACellDelegate>delegate;
@property(nonatomic,retain)NSArray* keywordsArray;
@property(nonatomic,retain)UILabel * advTitle;
- (void)freshCell:(int)tag style:(int)style title:(NSString*)title;
- (void)loadTitleImage:(NSString *)imageUrl;
-(void)loadBigImg:(NSString*)bigImgStr title:(NSString*)title subTitle:(NSString*)subtit;
-(void)loadFistImg:(NSString*)firstImgStr title:(NSString*)title subTitle:(NSString*)subtit;
-(void)loadsecondImg:(NSString*)secondImgStr title:(NSString*)title subTitle:(NSString*)subtit;
@end
@protocol HomePageModelACellDelegate <NSObject>
-(void)keywordBtnSelceted:(UIButton*)button type:(int)type;
-(void)promotionTapcell:(HomePageModelACell*)cell withIdenty:(int)tag;

@end