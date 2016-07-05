//
//  ADCCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "ADCCell.h"
#import "PowerfulBannerView.h"
#import <UIImageView+WebCache.h>

@interface ADCCell ()

@property (nonatomic) PowerfulBannerView *bannerView;
@end

@implementation ADCCell
-(void)awakeFromNib
{
    /*__weak typeof(self) weakSelf = self;
    self.iMGCallBack = ^(NSMutableArray * adImgArr){
        if (adImgArr.count == 0) {
            [weakSelf setDefaultADImg];
        }else
        {
            weakSelf.adsDataArr = [[NSMutableArray alloc]initWithCapacity:0];
            weakSelf.adsDataArr = adImgArr;
            PowerfulBannerView *bannerView = [weakSelf setUpBannerView];
            [weakSelf addSubview:bannerView];
        }
    };*/
//    if (self.adsDataArr.count == 0)
//    {
//        [self setDefaultADImg];
//    }
}

- (PowerfulBannerView *)bannerView {
    if (_bannerView == nil) {
        if (self.type == 1) {//来自老板娘页面
            _bannerView = [[PowerfulBannerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2.0)];
            [self addSubview:_bannerView];
        }else
        {
            _bannerView = [[PowerfulBannerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4.0)];
            [self addSubview:_bannerView];
        }

        
    }
    return _bannerView;
}

- (void)setAdsDataArr:(NSArray *)adsDataArr {
    if (adsDataArr.count !=0 ) {
        _adsDataArr = adsDataArr;
        [self setUpBannerView];
    } else {
        [self setDefaultADImg];
    }
}

-(void)setDefaultADImg
{
    if (self.type == 1) {//来自老板娘页面
        UIImageView * adimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2.0)];
        adimageView.image = [UIImage imageNamed:@"Lady_banner1"];
        [self.contentView addSubview:adimageView];
        
    }else
    {
        UIImageView * adimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4.0)];
        adimageView.image = [UIImage imageNamed:@"ScrollerAD"];
        [self.contentView addSubview:adimageView];
    }
    
}

- (void)setUpBannerView
{
    if (_bannerView == nil) {
        _bannerView = [[PowerfulBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        [self.contentView addSubview:_bannerView];
    }
    
    _bannerView.items = self.adsDataArr;
    _bannerView.loopingInterval = 3.f;
    _bannerView.autoLooping = YES;
    _bannerView.pageControl = [self setUpPageCOntroller:_bannerView];
    
    UIView *labelBGView = [[UIView alloc]initWithFrame:CGRectMake(0, _bannerView.frame.size.height - 40, _bannerView.frame.size.width-80, 40)];
    [_bannerView addSubview:labelBGView];
    labelBGView.backgroundColor = [UIColor clearColor];
    labelBGView.alpha = 0.7;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, labelBGView.frame.size.width-10, 40)];
    titleLabel.text = nil;
    titleLabel.textColor = [UIColor whiteColor];
    [labelBGView addSubview:titleLabel];
    
    self.bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        UIImageView *view = (UIImageView *)reusableView;
        if (!view) {
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
            view.clipsToBounds = YES;
        }
        if ([item isKindOfClass:[AdModel class]]) {
            AdModel *adModel = (AdModel *)item;
            [view sd_setImageWithURL:[NSURL URLWithString:adModel.image] placeholderImage:[UIImage imageNamed:@"advertisment"]];
        }
        if ([item isKindOfClass:[NSString class]]) {
            [view sd_setImageWithURL:[NSURL URLWithString:(NSString *)item] placeholderImage:[UIImage imageNamed:@"advertisment"]];
        }
        return view;
    };

    __weak __typeof(self) weakself = self;
    _bannerView.bannerDidSelectBlock = ^(PowerfulBannerView *banner, NSInteger index) {
        AdModel *adModel = weakself.adsDataArr[index];
        if (weakself.callbackHandler) {
            weakself.callbackHandler(adModel);
        }
    };
    
    // _bannerView.bannerIndexChangeBlock = ^(PowerfulBannerView *banner, NSInteger fromIndex, NSInteger toIndex) {};
}

-(UIPageControl *)setUpPageCOntroller:(PowerfulBannerView *)bannerView
{
    UIPageControl *pg = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth-80, kScreenWidth/2 -40, 80, 40)];
    pg.backgroundColor = [UIColor clearColor];
    pg.alpha = 0.7;
    [bannerView addSubview:pg];
    return pg ;
}

@end
