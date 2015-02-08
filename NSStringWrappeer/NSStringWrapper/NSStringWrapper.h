//
//  NSStringWrapper.h
//  NSStringWrapper
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Wrapper)

/**  Return the char value at the specified index. */
- (unichar) charAt:(int)index;

/**
 * Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (int) compareTo:(NSString*) anotherString;

- (int) compareToIgnoreCase:(NSString*) str;

- (BOOL) contains:(NSString*) str;

- (BOOL) startsWith:(NSString*)prefix;

- (BOOL) endsWith:(NSString*)suffix;

- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;

- (int) indexOfChar:(unichar)ch;

- (int) indexOfChar:(unichar)ch fromIndex:(int)index;

- (int) indexOfString:(NSString*)str;

- (int) indexOfString:(NSString*)str fromIndex:(int)index;

- (int) lastIndexOfChar:(unichar)ch;

- (int) lastIndexOfChar:(unichar)ch fromIndex:(int)index;

- (int) lastIndexOfString:(NSString*)str;

- (int) lastIndexOfString:(NSString*)str fromIndex:(int)index;

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (NSString *) trim;

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) split:(NSString*) separator;

// 颜色转换 "#029387"
- (UIColor*)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;

// 去除空格
- (NSString *)stringByTrimming;

#pragma mark - Time
/**
 *	@brief	时间戳转时间
 *
 *	@param 	timeStamp 	@"1410867094"
 *
 *	@return	time @"2014-09-16 19:31:34"
 */
- (NSString *)timeStampConvertTime:(NSString *)timeStamp;

/**
 *	@brief	当前时间转时间戳
 *
 *	@return	timeStamp 	@"1410867094"
 */
- (NSString *)currentTimeConvertTimeStamp;

/**
 *	@brief	时间转时间戳
 *
 *	@param 	time 	@"2014-09-16 19:31:34"
 *
 *	@return	timeStamp:@"1410867094"
 */
- (NSString *)timeConvertTimeStamp:(NSString *)time;

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

@end






