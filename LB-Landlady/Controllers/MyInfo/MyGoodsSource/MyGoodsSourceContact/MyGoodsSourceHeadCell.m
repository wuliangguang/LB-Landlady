//
//  MyGoodsSourceHeadCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceHeadCell.h"
#import "NSString+Helper.h"

@interface MyGoodsSourceHeadCell ()

@end

@implementation MyGoodsSourceHeadCell

- (IBAction)phoneCall:(id)sender {
    [self.contactPhone phoneCall];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
