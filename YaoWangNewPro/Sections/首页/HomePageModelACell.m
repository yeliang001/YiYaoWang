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
    
    
    
    [headImgView release];
    [adBg release];
    [keywordBtns release];
    [promotionImg release];
    [bigImg release];
    [advTitle release];
//    [bigSubTit release];
//    [bigTitle release];
    [firstSubTit release];
    [secSubTit release];
    [firstTit release];
    [secTit release];
    [firstImg release];
    [secImg release];
    [super dealloc];
}
@synthesize delegate;
@synthesize keywordsArray;
@synthesize advTitle;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        
        keywordBtns=[[NSMutableArray alloc] init];
        headImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, barHeight)];
        [self.contentView addSubview:headImgView];
        //ISSUE #6762
        self.advTitle=[[UILabel alloc] initWithFrame:CGRectMake(40, 7, 200, 30)];
        advTitle.font=[UIFont boldSystemFontOfSize:18];
        advTitle.backgroundColor=[UIColor clearColor];
        advTitle.textColor=[UIColor whiteColor];
        [headImgView addSubview:advTitle];
        
        titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        [headImgView addSubview:titleImageView];
        
        
        adBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, cellWidth, advHeight)];
        adBg.userInteractionEnabled=YES;
        [self.contentView addSubview:adBg];
        
        for (int i=0; i<4; i++) {
            UIButton* but=[UIButton buttonWithType:UIButtonTypeCustom];
            but.titleLabel.font=[UIFont systemFontOfSize:14];
            but.frame=CGRectMake(7+(65+15)*i, barHeight+advHeight+12, 65, 25);
            [self.contentView addSubview:but];
            [keywordBtns addObject:but];
        }
        //大图的图片 文字
        bigImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, advHeight-2, advHeight)];
        bigImg.userInteractionEnabled=YES;        
        [adBg addSubview:bigImg];
        
//        bigTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 8, 150, 20)];
//        bigTitle.font=[UIFont boldSystemFontOfSize:18];
//        bigTitle.backgroundColor=[UIColor clearColor];
//        [bigImg addSubview:bigTitle];
        
//        bigSubTit=[[UILabel alloc] initWithFrame:CGRectMake(5, 30, 150, 15)];
//        bigSubTit.textColor=[UIColor grayColor];
//        bigSubTit.backgroundColor=[UIColor clearColor];
//        [bigImg addSubview:bigSubTit];
        
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promotionTap:)];
        bigImg.tag=0;
        [bigImg addGestureRecognizer:tap];
        [tap release];

        
//        小图部分
        promotionImg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, advHeight, advHeight)];
        {
//       小图1
        UIView* promotion1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, advHeight, advHeight/2)];
        promotion1.tag=1;
        promotion1.backgroundColor=[UIColor clearColor];
        [promotionImg addSubview:promotion1];
        [promotion1 release];
        
        firstImg=[[UIImageView alloc] initWithFrame:CGRectMake(110, 15, 50, 50)];
        [promotion1 addSubview:firstImg];
        
        firstTit=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 120, 20)];
        firstTit.backgroundColor=[UIColor clearColor];
        firstTit.font=[UIFont systemFontOfSize:14];
        [promotion1 addSubview:firstTit];
        
        firstSubTit=[[UILabel alloc] initWithFrame:CGRectMake(5, 30, 120, 15)];
        firstSubTit.font=[UIFont systemFontOfSize:12];
        firstSubTit.backgroundColor=[UIColor clearColor];
        firstSubTit.textColor=[UIColor grayColor];
        [promotion1 addSubview:firstSubTit];
        
        UITapGestureRecognizer* tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promotionTap:)];
        promotion1.tag=1;
        [promotion1 addGestureRecognizer:tap1];
        [tap1 release];

        }
//        第二个小图
        {
        UIView* promotion2=[[UIView alloc] initWithFrame:CGRectMake(0, advHeight/2, advHeight, advHeight/2)];
        promotion2.backgroundColor=[UIColor clearColor];
        promotion2.tag=2;
        [promotionImg addSubview:promotion2];
        [promotion2 release];
        
        secImg=[[UIImageView alloc] initWithFrame:CGRectMake(110, 15, 50, 50)];
        [promotion2 addSubview:secImg];

        secTit=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 120, 20)];
        secTit.backgroundColor=[UIColor clearColor];
        secTit.font=[UIFont systemFontOfSize:14];
        [promotion2 addSubview:secTit];
        
        secSubTit=[[UILabel alloc] initWithFrame:CGRectMake(5, 30, 120, 15)];
        secSubTit.font=[UIFont systemFontOfSize:12];
        secSubTit.backgroundColor=[UIColor clearColor];
        secSubTit.textColor=[UIColor grayColor];
        [promotion2 addSubview:secSubTit];

        UITapGestureRecognizer* tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promotionTap:)];
        promotion2.tag=2;
        [promotion2 addGestureRecognizer:tap2];
        [tap2 release];
        }
        UIColor *lineColor=[UIColor colorWithRed:(175.0/255.0) green:(175.0/255.0) blue:(175.0/255.0) alpha:1];
        UIView* line0=[[UIView alloc] initWithFrame:CGRectMake(0, 80, 160, 0.5)];
        line0.backgroundColor=lineColor;
        [promotionImg addSubview:line0];
        [line0 release];

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
    NSString* headStr=[NSString stringWithFormat:@"modelBar%d.png",tag % 3];
    NSString* btStr=[NSString stringWithFormat:@"modelkeyword%d",tag % 3];

    UIColor* titColor=nil;
    if (tag==0) {
        titColor=[UIColor colorWithRed:(170.0/255.0) green:(53.0/255.0) blue:(1.0/255.0) alpha:1];
    }else if(tag==1){
        titColor=[UIColor colorWithRed:(90.0/255.0) green:(101.0/255.0) blue:(1.0/255.0) alpha:1];
        headStr=@"modelBar2.png";
        btStr=@"modelkeyword2.png";
    }else if(tag==2){
        titColor=[UIColor colorWithRed:(38.0/255.0) green:(61.0/255.0) blue:(102.0/255.0) alpha:1];
        headStr=@"modelBar1.png";
        btStr=@"modelkeyword1.png";
    }
    secTit.textColor=titColor;
    firstTit.textColor=titColor;
    headImgView.image=[UIImage imageNamed:headStr];
    if (title!=nil&&[title isKindOfClass:[NSString class]]&&title.length>0) {
        advTitle.text=title;
    }

    for (int i=0; i<keywordsArray.count; i++)
    {
        UIButton*bt=[OTSUtility safeObjectAtIndex:i inArray:keywordBtns];
        NSString* keyword=[OTSUtility safeObjectAtIndex:i inArray:keywordsArray];
        [bt setBackgroundImage:[UIImage imageNamed:btStr] forState:UIControlStateNormal];
        [bt setTitle:keyword forState:UIControlStateNormal];
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

- (void)loadTitleImage:(NSString *)imageUrl
{
    [titleImageView setImageWithURL:[NSURL URLWithString:imageUrl] refreshCache:NO];
}


-(void)loadBigImg:(NSString*)bigImgStr title:(NSString*)title subTitle:(NSString*)subtit{
    [bigImg setImageWithURL:[NSURL URLWithString:bigImgStr] refreshCache:NO ];
//    bigTitle.text=title;
//    bigSubTit.text=subtit;
}
-(void)loadFistImg:(NSString*)firstImgStr title:(NSString*)title subTitle:(NSString*)subtit{
    [firstImg setImageWithURL:[NSURL URLWithString:firstImgStr] refreshCache:NO];
    if (title!=nil&&[title isKindOfClass:[NSString class]]&&title.length>0) {
//        firstTit.text=title;
    }else{
        firstTit.text=@"";
    }
    if (subtit!=nil&&[subtit isKindOfClass:[NSString class]]&&subtit.length>0) {
        firstSubTit.text=subtit;
    }else{
        firstSubTit.text=@"";
    }
}

-(void)loadsecondImg:(NSString*)secondImgStr title:(NSString*)title subTitle:(NSString*)subtit{
    [secImg setImageWithURL:[NSURL URLWithString:secondImgStr] refreshCache:NO];
    if (title!=nil&&[title isKindOfClass:[NSString class]]&&title.length>0) {
//        secTit.text=title;
    }else{
        secTit.text=@"";
    }
    if (subtit!=nil&&[subtit isKindOfClass:[NSString class]]&&subtit.length>0) {
        secSubTit.text=subtit;
    }else{
        secSubTit.text=@"";
    }
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
