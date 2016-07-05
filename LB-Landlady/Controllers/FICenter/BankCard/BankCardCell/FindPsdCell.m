//
//  FindPsdCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/17.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "FindPsdCell.h"

@implementation FindPsdCell

- (void)awakeFromNib
{
    // Initialization code
    self.backView.userInteractionEnabled = YES;
    [_TF1 setValue:@1 forKey:@"limit"];
    [_TF2 setValue:@1 forKey:@"limit"];
    [_TF3 setValue:@1 forKey:@"limit"];
    [_TF4 setValue:@1 forKey:@"limit"];
    [_TF5 setValue:@1 forKey:@"limit"];
    [_TF6 setValue:@1 forKey:@"limit"];
    
    [_topTextField setValue:@6 forKey:@"limit"];
    _topTextField.tintColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TFChange:) name:UITextFieldTextDidChangeNotification object:_topTextField];
    
}
-(void)TFChange:(NSNotification *)notification
{
    UITextField * tf = (UITextField *)notification.object;
    _TF1.text = @"";
    _TF2.text = @"";
    _TF3.text = @"";
    _TF4.text = @"";
    _TF5.text = @"";
    _TF6.text = @"";
    NSString *str = tf.text;
    for (int i = 0  ; i < str.length ; i ++)
    {
        if (i == 0)
        {
            NSString * sunStr =[NSString stringWithFormat:@"%c",[str characterAtIndex:0]];
            _TF1.text = sunStr;
        }
        
        if (i == 1)
        {
            NSString * sunStr =[NSString stringWithFormat:@"%c",[str characterAtIndex:1]];
            _TF2.text = sunStr;
        }
        if (i == 2)
        {
            NSString * sunStr =[NSString stringWithFormat:@"%c",[str characterAtIndex:2]];
            _TF3.text = sunStr;
        }
        if (i == 3)
       {
           NSString * sunStr =[NSString stringWithFormat:@"%c",[str characterAtIndex:3]];
           _TF4.text = sunStr;
       }
        if (i  == 4)
       {
           NSString * sunStr =[NSString stringWithFormat:@"%c",[str characterAtIndex:4]];
           _TF5.text = sunStr;
       }
        if (i == 5)
       {
           NSString * sunStr =[NSString stringWithFormat:@"%c",[str characterAtIndex:5]];
           _TF6.text = sunStr;
           
       }
        self.psd(str);
       
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
