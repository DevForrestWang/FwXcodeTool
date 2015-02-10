//
//  NSStringWrapper.m
//  NSStringWrapper
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import "NSStringWrapper.h"
#import <CommonCrypto/CommonDigest.h>

#define IS_IOS7         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

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
- (NSInteger) compareTo:(NSString*) anotherString {
    return [self compare:anotherString];
}

/** Java-like method. Compares two strings lexicographically, ignoring case differences. */
- (NSInteger) compareToIgnoreCase:(NSString*) str {
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

- (NSInteger) indexOfChar:(unichar)ch{
    return [self indexOfChar:ch fromIndex:0];
}

- (NSInteger) indexOfChar:(unichar)ch fromIndex:(int)index{
    int len = self.length;
    for (int i = index; i < len; ++i) {
        if (ch == [self charAt:i]) {
            return i;
        }
    }
    return JavaNotFound;
}

- (NSInteger) indexOfString:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (NSInteger) indexOfString:(NSString*)str fromIndex:(int)index {
    NSRange fromRange = NSMakeRange(index, self.length - index);
    NSRange range = [self rangeOfString:str options:NSLiteralSearch range:fromRange];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (NSInteger) lastIndexOfChar:(unichar)ch {
    int len = self.length;
    for (int i = len-1; i >=0; --i) {
        if ([self charAt:i] == ch) {
            return i;
        }
    }
    return JavaNotFound;
}

- (NSInteger) lastIndexOfChar:(unichar)ch fromIndex:(int)index {
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

- (NSInteger) lastIndexOfString:(NSString*)str {
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return range.location;
}

- (NSInteger) lastIndexOfString:(NSString*)str fromIndex:(int)index {
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

+ (NSString *)trimString:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return string;
}

+ (id)checkNull:(id)source
{
    NSString *result = @"";
    if(!source || source == nil || [source isEqual:[NSNull null]]){
        return result;
    }
    
    return source;
}

- (NSString *)separateByDecimal
{
    NSString *source = self;
    NSString *subffixString = nil;
    
    NSRange tempRange = [self rangeOfString:@"."];
    if (tempRange.location != NSNotFound) {
        source = [source substringToIndex:tempRange.location];
        subffixString = [self substringFromIndex:tempRange.location];
    }else{
        subffixString = @"";
    }
    
    NSMutableString *mutableString = [NSMutableString stringWithCapacity:0];
    [source enumerateSubstringsInRange:NSMakeRange(0, source.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [mutableString insertString:substring atIndex: 0];
    }];
    
    NSMutableString *tempString = [NSMutableString stringWithCapacity:0];
    [mutableString enumerateSubstringsInRange:NSMakeRange(0, mutableString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [tempString appendString:substring];
        if ((substringRange.location + 1 ) % 3 == 0 && mutableString.length > substringRange.location + 1) {
            [tempString appendString:@","];
        }
    }];
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:0];
    [tempString enumerateSubstringsInRange:NSMakeRange(0, tempString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [resultString insertString:substring atIndex: 0];
    }];
    
    NSLog(@"%@%@",resultString,subffixString);
    return [NSString stringWithFormat:@"%@%@",resultString,subffixString];
}

+ (NSString *)generateUDID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(NULL);
    CFStringRef newUniqueIdString = CFUUIDCreateString(NULL, newUniqueId);
    
    NSString *MyString = [NSString  stringWithString:(__bridge NSString *)newUniqueIdString];
    
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return [MyString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSString *)timeStampConvertTime:(NSString *)timeStamp
{
    NSTimeInterval time = [timeStamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: detaildate]];
}

+ (NSString *)currentTimeConvertTimeStamp
{
    return  [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

+ (NSString *)timeConvertTimeStamp:(NSString *)time
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

+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    if (date == nil || dateFormat == nil) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
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

+ (NSString *)md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}

- (NSString *)md5
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}

#define     LocalStr_None           @""
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)stringURLEncoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:&=+$,/?%#[]"),
                                                                                 kCFStringEncodingUTF8));
}

+ (UIColor*)colorWithHexString:(NSString*)hexString andAlpha:(float)alpha {
    UIColor *col;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        col = [[self class] colorWithHexValue:hexValue andAlpha:alpha];
    } else {
        // invalid hex string
        col = [UIColor blackColor];
    }
    return col;
}

+ (UIColor*)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha {
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
            green:((float)((hexValue & 0xFF00) >> 8))/255.0
            blue:((float)(hexValue & 0xFF))/255.0
            alpha:alpha];
}

- (CGFloat)widthWithFont:(UIFont *)font
{
    return [self widthWithFont:font maxWidth:0];
}

- (CGFloat)widthWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    if (self.length == 0) {
        return 0.0;
    }
    CGSize textSize;
    if (!IS_IOS7) {
        if (maxWidth == 0) {
            textSize = [self textSizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21)];
        } else {
            textSize = [self textSizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, 21)];
        }
    } else {
        if (maxWidth == 0) {
            textSize = [self textSizeWithFont:font constrainedToSize:CGSizeMake(0, 21)];
        } else {
            textSize = [self textSizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, 21)];
        }
    }
    return textSize.width;
}

- (CGFloat)heightWithFixWidth:(CGFloat)width font:(UIFont *)font
{
    if (self.length == 0) {
        return 0.0;
    }
    CGSize textSize;
    if (!IS_IOS7) {
        textSize = [self textSizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    } else {
        textSize = [self textSizeWithFont:font constrainedToSize:CGSizeMake(width, 0)];
    }
    return textSize.height;
}

- (CGSize)textSizeWithFont:(UIFont *)font
{
    return [self textSizeWithFont:font constrainedToSize:CGSizeMake(0, 0)];
}

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize;
    if (!IS_IOS7) {
        if (CGSizeEqualToSize(size, CGSizeMake(0, 0))) {
            textSize = [self sizeWithFont:font];
        } else {
            textSize = [self sizeWithFont:font
                        constrainedToSize:size
                            lineBreakMode:NSLineBreakByCharWrapping];
        }
    } else {
        if (CGSizeEqualToSize(size, CGSizeMake(0, 0))) {
            //            NSDictionary *attributes = @{NSFontAttributeName:font}
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            textSize = [self sizeWithAttributes:attributes];
        } else {
            NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            CGRect rect = [self boundingRectWithSize:size
                                             options:option
                                          attributes:attributes
                                             context:nil];
            textSize = rect.size;
        }
    }
    return textSize;
}

- (CGSize)textDrawAtPoint:(CGPoint)point withFont:(UIFont *)font
{
    return [self drawAtPoint:point withFont:font];
}

- (CGSize)textDrawInRect:(CGRect)rect withFont:(UIFont *)font
{
    return [self drawInRect:rect withFont:font];
}

- (CGSize)textDrawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self drawInRect:rect withFont:font lineBreakMode:lineBreakMode];
}

- (CGSize)textDrawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)textAlignment
{
    return [self drawInRect:rect withFont:font lineBreakMode:lineBreakMode alignment:textAlignment];
}

@end
