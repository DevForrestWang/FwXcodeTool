//
//  NSStringWrapper.m
//  NSStringWrapper
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import "NSStringWrapper.h"

@implementation NSString(Wrapper)

#define JavaNotFound -1

/**  Java-like method. Returns the char value at the specified index. */
- (unichar) charAt:(int)index {
    return [self characterAtIndex:index];
}

/**
 * Java-like method. Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (int) compareTo:(NSString*) anotherString {
    return [self compare:anotherString];
}

/** Java-like method. Compares two strings lexicographically, ignoring case differences. */
- (int) compareToIgnoreCase:(NSString*) str {
    return [self compare:str options:NSCaseInsensitiveSearch];
}

/** Java-like method. Returns true if and only if this string contains the specified sequence of char values. */
- (BOOL) contains:(NSString*) str {
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

- (BOOL) startsWith:(NSString*)prefix {
    return [self hasPrefix:prefix];
}

- (BOOL) endsWith:(NSString*)suffix {
    return [self hasSuffix:suffix];
}

- (BOOL) equals:(NSString*) anotherString {
    return [self isEqualToString:anotherString];
}

- (BOOL) equalsIgnoreCase:(NSString*) anotherString {
    return [[self toLowerCase] equals:[anotherString toLowerCase]];
}

- (int) indexOfChar:(unichar)ch{
    return [self indexOfChar:ch fromIndex:0];
}

- (int) indexOfChar:(unichar)ch fromIndex:(int)index{
    int len = self.length;
    for (int i = index; i < len; ++i) {
        if (ch == [self charAt:i]) {
            return i;
        }
    }
    return JavaNotFound;
}

- (int) indexOfString:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (int) indexOfString:(NSString*)str fromIndex:(int)index {
    NSRange fromRange = NSMakeRange(index, self.length - index);
    NSRange range = [self rangeOfString:str options:NSLiteralSearch range:fromRange];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (int) lastIndexOfChar:(unichar)ch {
    int len = self.length;
    for (int i = len-1; i >=0; --i) {
        if ([self charAt:i] == ch) {
            return i;
        }
    }
    return JavaNotFound;
}

- (int) lastIndexOfChar:(unichar)ch fromIndex:(int)index {
    int len = self.length;
    if (index >= len) {
        index = len - 1;
    }
    for (int i = index; i >= 0; --i) {
        if ([self charAt:i] == ch) {
            return index;
        }
    }
    return JavaNotFound;
}

- (int) lastIndexOfString:(NSString*)str {
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (int) lastIndexOfString:(NSString*)str fromIndex:(int)index {
    NSRange fromRange = NSMakeRange(0, index);
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:fromRange];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex {
    if (endIndex <= beginIndex) {
        return @"";
    }
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    return [self substringWithRange:range];
}

- (NSString *) toLowerCase {
    return [self lowercaseString];
}

- (NSString *) toUpperCase {
    return [self uppercaseString];
}

- (NSString *) trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement {
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (NSArray *) split:(NSString*) separator {
    return [self componentsSeparatedByString:separator];
}

- (UIColor*)colorWithHexString:(NSString*)hexString andAlpha:(float)alpha {
    UIColor *col;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        col = [self colorWithHexValue:hexValue andAlpha:alpha];
    } else {
        // invalid hex string
        col = [UIColor blackColor];
    }
    return col;
}

- (UIColor*)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha {
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
            green:((float)((hexValue & 0xFF00) >> 8))/255.0
            blue:((float)(hexValue & 0xFF))/255.0
            alpha:alpha];
}

#ifdef GNUSTEP
- (NSString *)stringByTrimming
{
    return [self stringByTrimmingSpaces];
}
#else
- (NSString *)stringByTrimming
{
    NSMutableString *mStr = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)mStr);
    
    NSString *result = [mStr copy];
    
    return result;
}
#endif

- (NSString *)timeStampConvertTime:(NSString *)timeStamp
{
    NSTimeInterval time = [timeStamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: detaildate]];
}

- (NSString *)currentTimeConvertTimeStamp
{
    return  [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

- (NSString *)timeConvertTimeStamp:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [dateFormatter dateFromString:time];
    if (date == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        date = [dateFormatter dateFromString:time];
    }
    if (date == nil) {
        return time;
    }
    return  [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}

- (NSString *)timeStampConvertToTimeFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    if (date == nil) {
        NSLog(@"convert to format fail");
        return self;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
}

- (NSString *)timeFormatConvertToTimeStamp:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:self];
    if (date == nil) {
        NSLog(@"convert to timeStamp fail");
        return self;
    }
    return [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
}

@end
