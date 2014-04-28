//
//  HomePageModelACell.m
//  TheStoreApp
//
//  Created by yuan jun on 13-1-15.
//
//

#import "HomePageModelACell.h"
#import "SDImageView+SDWebCache.h"
#import "OTSUtility.h"
#define barHeight 40
#define cellHeight 250
#define advHeight 160
#define cellWidth   320
@implementation HomePageModelACell
-(void)dealloc{
    [keywordsArray release];
    [adBg release];
    [promotionImg release];
    [bigImg release];
    [advTitle release];
    [super dealloc];
}

@synthesize delegate;
@synthesize keywordsArray;
@synthesize advTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        adBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, advHeight)];
        adBg.userInteractionEnabled=YES;
        [self.contentView addSubview:adBg];
        
        /*不在初始化cell的时候直接初始化这几个按钮，因为在旧版中，数值是固定的，现在是可变的*/
//        for (int i=0; i<4; i++) {
//            UIButton* but=[UIButton buttonWithType:UIButtonTypeCustom];
//            but.titleLabel.font=[UIFont systemFontOfSize:14];
//            but.frame=CGRectMake(7+(65+15)*i, barHeight+advHeight+12, 65, 25);
//            [self.contentView addSubview:but];
//            [keywordBtns addObject:but];
//        }
        //大图的图片 文字
        bigImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, advHeight-2, advHeight)];
        bigImg.userInteractionEnabled=YES;        
        [adBg addSubview:bigImg];
    
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promotionTap:)];
        bigImg.tag=0;
        [bigImg addGestureRecognizer:tap];
        [tap release];

        promotionImg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, advHeight, advHeight)];
        
        UIColor *lineColor=[UIColor colorWithRed:(175.0/255.0) green:(175.0/255.0) blue:(175.0/255.0) alpha:1];

        [adBg addSubview:promotionImg];
        UIView* line=[[UIView alloc] initWithFrame:CGRectMake(0, 161, 320, 0.5)];
        line.backgroundColor=lineColor;
        [adBg addSubview:line];
        [line release];
        UIView*verline=[[UIView alloc] initWithFrame:CGRectMake(160, 0, 0.5, 161)];
        verline.backgroundColor=lineColor;
        [adBg addSubview:verline];
        [verline release];
    }
    return self;
}

-(void)promotionTap:(id)sender{
    int tag;
        UITapGestureRecognizer* ges=(UITapGestureRecognizer*)sender;
        tag=[ges view].tag;
    [delegate promotionTapcell:self withIdenty:tag];
}


- (void)freshCell:(int)tag style:(int)style title:(NSString*)title{
    //分颜色
    
    NSString* btStr=[NSString stringWithFormat:@"modelkeyword%d",tag % 3];

    UIColor* titColor=nil;
    if (tag==0) {
        titColor=[UIColor colorWithRed:(170.0/255.0) green:(53.0/255.0) blue:(1.0/255.0) alpha:1];
    }else if(tag==1){
        titColor=[UIColor colorWithRed:(90.0/255.0) green:(101.0/255.0) blue:(1.0/255.0) alpha:1];
        
        btStr=@"modelkeyword2.png";
    }else if(tag==2){
        titColor=[UIColor colorWithRed:(38.0/255.0) green:(61.0/255.0) blue:(102.0/255.0) alpha:1];
        btStr=@"modelkeyword1.png";
    }
    if (title!=nil&&[title isKindOfClass:[NSString class]]&&title.length>0) {
        advTitle.text=title;
    }

    for (int i=0; i<keywordsArray.count; i++)
    {
        
        UIButton* but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.titleLabel.font=[UIFont systemFontOfSize:14];
        but.frame=CGRectMake(160+7+(65+15)*(i%2), 40+((i/2)*25)+12, 65, 25);
        [self.contentView addSubview:but];
        /*不从keywordBtns数组拿btn，现在时动态根据keywordsArray来获取*/
//        UIButton*bt=[OTSUtility safeObjectAtIndex:i inArray:keywordBtns];
        UIButton*bt = but;
        [but release];
        NSString* keyword=[OTSUtility safeObjectAtIndex:i inArray:keywordsArray];
        [bt setBackgroundImage:[UIImage imageNamed:btStr] forState:UIControlStateNormal];
        [bt setTitle:keyword forState:UIControlStateNormal];
        bt.titleLabel.textColor  = [UIColor blackColor];
        [bt addTarget:self action:@selector(keywordClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(style==1)
    {
        //左大图
        promotionImg.frame=CGRectMake(advHeight, 0, advHeight, advHeight);
        bigImg.frame=CGRectMake(0, 0, advHeight-2, advHeight);
    }
    else if(style==2)
    {
        promotionImg.frame=CGRectMake(0, 0, advHeight, advHeight);
        bigImg.frame=CGRectMake(advHeight+2, 0, advHeight-2, advHeight);
    }
}


-(void)loadBigImg:(NSString*)bigImgStr title:(NSString*)title subTitle:(NSString*)subtit{
    [bigImg setImageWithURL:[NSURL URLWithString:bigImgStr] refreshCache:NO ];
}
-(void)loadFistImg:(NSString*)firstImgStr title:(NSString*)title subTitle:(NSString*)subtit{
//    [firstImg setImageWithURL:[NSURL URLWithString:firstImgStr] refreshCache:NO];
//    if (title!=nil&&[title isKindOfClass:[NSString class]]&&title.length>0) {
////        firstTit.text=title;
//    }else{
//        firstTit.text=@"";
//    }
//    if (subtit!=nil&&[subtit isKindOfClass:[NSString class]]&&subtit.length>0) {
//        firstSubTit.text=subtit;
//    }else{
//        firstSubTit.text=@"";
//    }
}

-(void)loadsecondImg:(NSString*)secondImgStr title:(NSString*)title subTitle:(NSString*)subtit{
//    [secImg setImageWithURL:[NSURL URLWithString:secondImgStr] refreshCache:NO];
//    if (title!=nil&&[title isKindOfClass:[NSString class]]&&title.length>0) {
////        secTit.text=title;
//    }else{
//        secTit.text=@"";
//    }
//    if (subtit!=nil&&[subtit isKindOfClass:[NSString class]]&&subtit.length>0) {
//        secSubTit.text=subtit;
//    }else{
//        secSubTit.text=@"";
//    }
}

-(void)keywordClick:(id)sender{
    if (delegate!=nil) {
        [delegate keywordBtnSelceted:sender type:self.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
