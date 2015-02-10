//
//  NSStringWrapper.h
//  NSStringWrapper
//
//  Created by Forrest on 15-2-10.
//  Copyright (c) 2012年 Forrest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(Wrapper)

/**
 *  返回指定位置的值
 *
 *  @param unichar index 位置
 *
 *  @return 值
 */
- (unichar) charAt:(int)index;

/**
 * Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (NSInteger) compareTo:(NSString*) anotherString;

- (NSInteger) compareToIgnoreCase:(NSString*) str;

- (BOOL) contains:(NSString*) str;

- (BOOL) startsWith:(NSString*)prefix;

- (BOOL) endsWith:(NSString*)suffix;

- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;

- (NSInteger) indexOfChar:(unichar)ch;

- (NSInteger) indexOfChar:(unichar)ch fromIndex:(int)index;

- (NSInteger) indexOfString:(NSString*)str;

- (NSInteger) indexOfString:(NSString*)str fromIndex:(int)index;

- (NSInteger) lastIndexOfChar:(unichar)ch;

- (NSInteger) lastIndexOfChar:(unichar)ch fromIndex:(int)index;

- (NSInteger) lastIndexOfString:(NSString*)str;

- (NSInteger) lastIndexOfString:(NSString*)str fromIndex:(int)index;

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (NSString *) trim;

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) split:(NSString*) separator;

/**
 *  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)stringByTrimming;

/**
 *  去除字符串左右两端空格
 *
 *  @param string 输入字符串
 *
 *  @return 返回字符串
 */
+ (NSString *)trimString:(NSString *)string;

+ (id)checkNull:(id)source;

/**
 *  字符转为千位符分隔格式
 *
 *  @return 千位符分隔格式
 */
- (NSString *)separateByDecimal;

+ (NSString *)generateUDID;

#pragma mark - Time
/**
 *  时间戳转时间
 *
 *  @param timeStamp @"1410867094"
 *
 *  @return @"2014-09-16 19:31:34"
 */
+ (NSString *)timeStampConvertTime:(NSString *)timeStamp;

/**
 *	@brief	当前时间转时间戳
 *
 *	@return	timeStamp 	@"1410867094"
 */
+ (NSString *)currentTimeConvertTimeStamp;

/**
 *	@brief	时间转时间戳
 *
 *	@param 	time 	@"2014-09-16 19:31:34"
 *
 *	@return	timeStamp:@"1410867094"
 */
+ (NSString *)timeConvertTimeStamp:(NSString *)time;

+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *  日期时间戳字符串转为其他格式日期字符串
 *
 *  @param format 日期格式
 *
 *  @return 设定格式的日期字符串
 */
- (NSString *)timeStampConvertToTimeFormat:(NSString *)format;

/**
 *  格式日期字符串转为日期时间戳字符串
 *
 *  @param format 日期格式
 *
 *  @return 时间戳字符串
 */
- (NSString *)timeFormatConvertToTimeStamp:(NSString *)format;

#pragma mark - md5
+ (NSString *)md5:(NSString *)str;

- (NSString *)md5;

/**
 *  将字符串转换为Base64
 *
 *  @param text 转换的字符串
 *
 *  @return Base64值
 */
+ (NSString *)base64StringFromText:(NSString *)text;

/**
 *  将Base64转换为正常数据
 *
 *  @param base64 Base64值
 *
 *  @return 转换后的结果
 */
+ (NSString *)textFromBase64String:(NSString *)base64;

/**
 *  URL字符串编码
 *
 *  @return 编码后的URL
 */
- (NSString *)stringURLEncoding;

#pragma mark - Font
/**
 *  颜色转换
 *
 *  @param hexString "#029387"
 *  @param alpha     alpha值
 *
 *  @return UIColor对象
 */
+ (UIColor*)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;

/*
 * 文字宽度 (1行, 最大宽度为预设CGFLOAT_MAX)
 */
- (CGFloat)widthWithFont:(UIFont *)font;

/*
 * 文字宽度 (1行, 最大宽度为maxWidth)
 */
- (CGFloat)widthWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/*
 * 固定宽度的文字高度
 */
- (CGFloat)heightWithFixWidth:(CGFloat)width font:(UIFont *)font;

/*
 * 文字size (1行)
 */
- (CGSize)textSizeWithFont:(UIFont *)font;

/*
 * 文字size
 */
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/*
 * 文字size
 */
- (CGSize)textDrawAtPoint:(CGPoint)point withFont:(UIFont *)font;

- (CGSize)textDrawInRect:(CGRect)rect withFont:(UIFont *)font;

- (CGSize)textDrawInRect:(CGRect)rect
                withFont:(UIFont *)font
           lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)textDrawInRect:(CGRect)rect
                withFont:(UIFont *)font
           lineBreakMode:(NSLineBreakMode)lineBreakMode
               alignment:(NSTextAlignment)textAlignment;
@end
