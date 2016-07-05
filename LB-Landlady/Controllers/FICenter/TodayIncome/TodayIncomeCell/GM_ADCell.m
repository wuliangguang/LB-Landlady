//
//  GM_ADCell.m
//  MeZoneB_Bate
//
//  Created by 李宝宝 on 15/11/24.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "GM_ADCell.h"
#import "PowerfulBannerView.h"
#import <UIImageView+WebCache.h>

@interface GM_ADCell ()

@property (nonatomic) UIImageView *defaultImageView;
@end

@implementation GM_ADCell

- (void)setAdsDataArr:(NSArray *)adsDataArr {
    if (adsDataArr && adsDataArr != _adsDataArr && adsDataArr.count > 0) {
        _adsDataArr = adsDataArr;
        [self setUpBannerView];
    } else {
        self.defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4.0)];
        [self.contentView addSubview:self.defaultImageView];
        if (self.type == 1) {
            self.defaultImageView.image = [UIImage imageNamed:@"ScrollerAD"];
        } else {
            self.defaultImageView.image = [UIImage imageNamed:@"FP_AD"];
        }
    }
}

//- (void)setPlaceholderImage:(NSString *)placeholderImage {
//    self.defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4.0)];
//    [self.contentView addSubview:self.defaultImageView];
//    self.defaultImageView.image = [UIImage imageNamed:placeholderImage];
//}

- (PowerfulBannerView *)setUpBannerView {
    if (self.defaultImageView) {
        [self.defaultImageView removeFromSuperview];
    }
    PowerfulBannerView *bannerView = [[PowerfulBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4.0)];
    bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        UIImageView *view = (UIImageView *)reusableView;
        if (!view) {
            view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.clipsToBounds = YES;
        }
        if ([item isKindOfClass:[NSString class]]) {
            [view sd_setImageWithURL:[NSURL URLWithString:item] placeholderImage:[UIImage imageNamed:@"advertisment"]];
        } else if ([item isKindOfClass:[AdModel class]]) {
            [view sd_setImageWithURL:[NSURL URLWithString:((AdModel *)item).image] placeholderImage:[UIImage imageNamed:@"advertisment"]];
        }
        
        return view;
    };

    bannerView.items           = self.adsDataArr;
    bannerView.loopingInterval = 3.f;
    bannerView.autoLooping     = YES;
    bannerView.pageControl     = [self setUpPageCOntroller:bannerView];
    
    UIView *labelBGView = [[UIView alloc]initWithFrame:CGRectMake(0, bannerView.frame.size.height - 40, bannerView.frame.size.width-80, 40)];
    [bannerView addSubview:labelBGView];
    labelBGView.backgroundColor = [UIColor clearColor];
    labelBGView.alpha = 0.7;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, labelBGView.frame.size.width-10, 40)];
    titleLabel.text = nil;
    titleLabel.textColor = [UIColor whiteColor];
    [labelBGView addSubview:titleLabel];
    
    bannerView.bannerDidSelectBlock = ^(PowerfulBannerView *banner, NSInteger index){
        NSLog(@"点击了广告：%@", [banner.items objectAtIndex:index]);
        AdModel *adModel = self.adsDataArr[index];
        if (self.callbackHandler) {
            self.callbackHandler(adModel);
        }
    };
    
    bannerView.bannerIndexChangeBlock = ^(PowerfulBannerView *banner, NSInteger fromIndex, NSInteger toIndex) {};
    [self.contentView addSubview:bannerView];
    
    return bannerView;
}

- (UIPageControl *)setUpPageCOntroller:(PowerfulBannerView *)bannerView {
    UIPageControl *pg = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth-80, kScreenWidth/2 -40, 80, 40)];
    pg.backgroundColor = [UIColor clearColor];
    pg.alpha = 0.7;
    [bannerView addSubview:pg];
    return pg ;
}

@end
