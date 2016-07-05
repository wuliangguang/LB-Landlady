//
//  GLLabel.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/14.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "GLLabel.h"

@implementation GLLabel
+ (NSAttributedString *)annualRateStr:(NSString *)str {
    return [self annualRateStr:str WithBiggerFont:[UIFont systemFontOfSize:30] smallFont:[UIFont systemFontOfSize:18]];
}

+ (NSAttributedString *)annualRateStr:(NSString *)str WithBiggerFont:(UIFont *)bigFont smallFont:(UIFont *)smallFont {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange rangeforSth = NSMakeRange(0, 1);
    [attributedString addAttribute:NSFontAttributeName value:smallFont range:rangeforSth];
    
    NSRange range = [str rangeOfString:@"."];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    [attributedString addAttribute:NSFontAttributeName value:bigFont range:NSMakeRange(1, range.location)];
    [attributedString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(range.location, str.length-range.location)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
    return attributedString;
}

+ (NSAttributedString *)attributeStrWithBigStr:(NSString *)bigStr smallStr:(NSString *)smallStr {
    return [self attributeStrWithBigStr:bigStr bigFont:[UIFont systemFontOfSize:18] smallStr:smallStr smallFont:[UIFont systemFontOfSize:13.0f]];
}

+ (NSAttributedString *)attributeStrWithBigStr:(NSString *)bigStr bigFont:(UIFont *)bigFont smallStr:(NSString *)smallStr smallFont:(UIFont *)smallFont {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bigStr attributes:@{NSFontAttributeName : bigFont}];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:smallStr attributes:@{NSFontAttributeName : smallFont}]];
    return attributedString;
}

//方式一比较容易处理复杂的格式，但是属性设置比较繁多复杂，而方式二的属性设置比较简单明了，却不善于处理复杂多样的格式控制，但是不善于并不等于不能，可以通过属性字符串分段的方式来达到方式一的效果

-(NSMutableAttributedString *)AttributeStringWith:(UIFont *)font Color:(UIColor *)color ForString:(NSString * )string Range:(NSRange)range TipFont:(UIFont *)tipfont1 TipColor:(UIColor *)tipcolor1 TipRange:(NSRange)tiprange1
{
    //第一段
    NSDictionary * attributedDic1 = @{NSFontAttributeName :font,NSForegroundColorAttributeName:color};
    NSAttributedString * attributedString1 = [[NSAttributedString alloc]initWithString:[string substringWithRange:range] attributes:attributedDic1];
    //第二段
    NSDictionary * attributedDic2 = @{NSFontAttributeName:tipfont1,NSForegroundColorAttributeName:tipcolor1};
    NSAttributedString * attributedString2 = [[NSAttributedString alloc]initWithString:[string substringWithRange:tiprange1] attributes:attributedDic2];
    //合并
    NSMutableAttributedString * ATTRiString = [[NSMutableAttributedString alloc]initWithAttributedString:attributedString1];
    [ATTRiString appendAttributedString:attributedString2];
    return ATTRiString;
    
    
}


-(NSDictionary *)createAttributedDictionaryWithFont:(UIFont *)font Color:(UIColor *)color
{
    NSDictionary * attributedDic = [NSDictionary dictionaryWithObjectsAndKeys:NSFontAttributeName,font,NSForegroundColorAttributeName,color, nil];
    return attributedDic;
}

-(void)MutableAttributedString:(NSString * )text AllColor:(UIColor *)allColor Color:(UIColor *)tipColor Range:(NSRange)range WithStyle:(NSUnderlineStyle)style AndLineColor:(UIColor *)lineColor
{
    //创建 NSMutableAttributedString
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    //添加属性
    [attributeString addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, text.length)];
    
    [attributeString addAttribute:NSForegroundColorAttributeName value:tipColor range:range];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:@(style) range:range];
    [attributeString addAttribute:NSUnderlineColorAttributeName value:lineColor range:range];
    self.attributedText = attributeString;
    
}



-(void)MutableAttributedStringForLabelWithString:(NSString * )text withFont:(NSInteger)font WithColor:(UIColor * )color WithStyle:(NSUnderlineStyle)style
{
    //dic里面存放text需要设置的属性；
    NSDictionary * attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName,color,NSForegroundColorAttributeName,@(style),NSUnderlineStyleAttributeName, nil];
    //设置需要进行富文本处理的AttributeString
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:text attributes:attributeDic];
    self.attributedText = attributeString;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setLineBreakMode:NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail];
        [self setBackgroundColor:[UIColor clearColor]];
        //        [self setTextColor:self.labColor];
        [self setUserInteractionEnabled:YES];
        [self setNumberOfLines:0];
        
    }
    return self;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self MutableAttributedString:self.text AllColor:LD_COLOR_ELEVEN Color:[UIColor whiteColor] Range:NSMakeRange(11, 9) WithStyle:NSUnderlineStyleSingle AndLineColor:[UIColor whiteColor]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self MutableAttributedString:self.text AllColor:LD_COLOR_ELEVEN Color:LD_COLOR_NINE Range:NSMakeRange(11, 9) WithStyle:NSUnderlineStyleSingle AndLineColor:LD_COLOR_NINE];
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x >= self.frame.origin.x && point.x <= self.frame.size.width && point.y >= self.frame.origin.y && point.y <= self.frame.size.height )//点击的点在label内部
    {
        [self.delegate GLLabel:self touchesWithTag:self.tag];
    }
}



@end
