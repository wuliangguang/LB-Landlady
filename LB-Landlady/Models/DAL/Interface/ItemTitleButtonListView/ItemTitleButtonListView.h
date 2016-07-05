//
//  ItemTitleButtonListView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTitleButtonListView : UIView

@property (nonatomic) NSMutableArray *items;
@property (nonatomic, copy) block_id_t callbackHandler;
@end
