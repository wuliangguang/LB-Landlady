//
//  GLLabel.h
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/14.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLabel : UILabel
@property(nonatomic,assign)id delegate;
+ (NSAttributedString *)annualRateStr:(NSString *)str;
+ (NSAttributedString *)annualRateStr:(NSString *)str WithBiggerFont:(UIFont *)bigFont smallFont:(UIFont *)smallFont;

+ (NSAttributedString *)attributeStrWithBigStr:(NSString *)bigStr smallStr:(NSString *)smallStr;
+ (NSAttributedString *)attributeStrWithBigStr:(NSString *)bigStr bigFont:(UIFont *)bigFont smallStr:(NSString *)smallStr smallFont:(UIFont *)smallFont;

/**
 *  方式一比较容易处理复杂的格式，但是属性设置比较繁多复杂，而方式二的属性设置比较简单明了，却不善于处理复杂多样的格式控制，但是不善于并不等于不能，可以通过属性字符串分段的方式来达到方式一的效果
 *
 *  @param font      第一段的字体
 *  @param color     第一段的颜色
 *  @param string    要处理的文字
 *  @param range     第一段的位置
 *  @param tipfont1  第二段的字体
 *  @param tipcolor1 第二段的颜色
 *  @param tiprange1 第二段的位置
 *
 *  @return 富文本字符串
 */

-(NSMutableAttributedString *)AttributeStringWith:(UIFont *)font Color:(UIColor *)color ForString:(NSString * )string Range:(NSRange)range TipFont:(UIFont *)tipfont1 TipColor:(UIColor *)tipcolor1 TipRange:(NSRange)tiprange1;
/**
 *  返回富文本的属性字典（方式二）
 *
 *  @param font  字体
 *  @param color 字体颜色
 *
 *  @return 富文本的属性字典
 */
-(NSDictionary *)createAttributedDictionaryWithFont:(UIFont *)font Color:(UIColor *)color;
/**
 *  给字符串不同的位置设置不同的颜色（方式一）
 *
 *  @param text     label的文字
 *  @param allColor 整体的颜色
 *  @param tipColor 着重凸显的颜色
 *  @param range    要凸显的文字的位置信息
 */
-(void)MutableAttributedString:(NSString * )text AllColor:(UIColor *)allColor Color:(UIColor *)tipColor Range:(NSRange)range WithStyle:(NSUnderlineStyle)style AndLineColor:(UIColor *)lineColor;

/**
 *  为某一label的文字设置多个属性
 *
 *  @param text  label的文字
 *  @param font  label的字体大小
 *  @param color label字体的颜色
 *  @param style label的下划线格式
 */
-(void)MutableAttributedStringForLabelWithString:(NSString * )text withFont:(NSInteger)font WithColor:(UIColor * )color WithStyle:(NSUnderlineStyle)style;



-(id)initWithFrame:(CGRect)frame;
@end

@protocol GLLabelDelegate <NSObject>

@required
-(void)GLLabel:(UILabel *)label touchesWithTag:(NSInteger)tag;
@end