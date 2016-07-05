//
//  ButtonView.h
//  demo
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,assign)NSInteger criticalValue;
@property (nonatomic) NSIndexPath *selectedIndexPath;
@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,assign)NSInteger selectedNum;
@property(nonatomic,copy)void(^buttonIndexClickBlock)(NSInteger num);
@end
