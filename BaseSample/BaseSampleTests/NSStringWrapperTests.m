//
//  NSStringWrapperTests.m
//  NSStringWrapperTests
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import "NSStringWrapperTests.h"
#import "NSStringWrapper.h"

@implementation NSStringWrapperTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCompareTo {
    STAssertTrue([@"abc" compareTo:@"abc"] == 0, @"They should be equal.");
    STAssertTrue([@"aaa" compareTo:@"abc"] == -1, @"They should be -1.");
    STAssertTrue([@"ac" compareTo:@"abc"] == 1, @"They should be 1.");
}

- (void)testCompareToIgnoreCase {
    STAssertTrue([@"abc" compareToIgnoreCase:@"aBc"] == 0, @"They should be equal.");
    STAssertTrue([@"aaa" compareToIgnoreCase:@"ABC"] == -1, @"They should be -1.");
    STAssertTrue([@"AC" compareToIgnoreCase:@"abc"] == 1, @"They should be 1.");
}

- (void)testContains {
    STAssertTrue([@"abcdef" contains:@"a"], @"It should contain.");
    STAssertTrue([@"abcdef" contains:@"f"], @"It should contain.");
    STAssertTrue([@"abcdef" contains:@"ef"], @"It should contain.");
    STAssertTrue([@"abc" contains:@"abc"], @"It should contain.");
    STAssertFalse([@"" contains:@"a"], @"It should not contain");
    STAssertFalse([@"ddd" contains:@"a"], @"It should not contain");
    STAssertFalse([@"aa" contains:@"aab"], @"It should not contain");
}


- (void)testStartsWith {
    STAssertTrue([@"abcdef" startsWith:@"abc"], @"");
    STAssertTrue([@"aa" startsWith:@"aa"], @"");
    STAssertFalse([@"aa" startsWith:@""], @"");
    STAssertFalse([@"abc" startsWith:@"b"], @"");
    STAssertFalse([@"abc" startsWith:@"abcd"], @"");
}

- (void)testEndsWith {
    STAssertTrue([@"abcdef" endsWith:@"def"], @"");
    STAssertTrue([@"aa" endsWith:@"aa"], @"");
    STAssertFalse([@"aa" endsWith:@""], @"");
    STAssertFalse([@"abc" endsWith:@"b"], @"");
    STAssertFalse([@"abc" endsWith:@"dabc"], @"");
}

- (void)testEquals {
    STAssertTrue([@"abc" equals:@"abc"], @"They should be equal.");
    STAssertTrue([@"" equals:@""], @"They should be equal.");
    STAssertFalse([@"aaa" equals:@"abc"], @"They should not be equal.");
    STAssertFalse([@"ac" equals:@"abc"], @"They should not be equal.");
    STAssertFalse([@"" equals:@"abc"], @"They should not be equal.");
    STAssertFalse([@"a" equals:@""], @"They should not be equal.");
    STAssertFalse([@"abcd" equals:@"abc"], @"They should not be equal.");
    STAssertFalse([@"abC" equals:@"abc"], @"They should not be equal.");
}

- (void)testEqualsIgnoreCase {
    STAssertTrue([@"abc" equalsIgnoreCase:@"abC"], @"They should be equal.");
    STAssertTrue([@"" equalsIgnoreCase:@""], @"They should be equal.");
    STAssertFalse([@"aaa" equalsIgnoreCase:@"abc"], @"They should not be equal.");
    STAssertFalse([@"ac" equalsIgnoreCase:@"abc"], @"They should not be equal.");
    STAssertFalse([@"" equalsIgnoreCase:@"abc"], @"They should not be equal.");
    STAssertFalse([@"a" equalsIgnoreCase:@""], @"They should not be equal.");
    STAssertFalse([@"abcd" equalsIgnoreCase:@"abc"], @"They should not be equal.");
    STAssertTrue([@"abC" equalsIgnoreCase:@"abc"], @"They should be equal.");
}

- (void)testIndexOfChar {
    STAssertEquals(-1, [@"abc" indexOfChar:'d'], @"");
    STAssertEquals(1, [@"abc" indexOfChar:'b'], @"");
}

- (void)testIndexOfCharFromIndex {
    STAssertEquals(-1, [@"abc" indexOfChar:'d' fromIndex:0], @"");
    STAssertEquals(1, [@"abc" indexOfChar:'b' fromIndex:1], @"");
    STAssertEquals(3, [@"abcbb" indexOfChar:'b' fromIndex:2], @"");
}

- (void)testIndexOfString {
    STAssertEquals(-1, [@"abc" indexOfString:@"dd"], @"");
    STAssertEquals(1, [@"abc" indexOfString:@"bc"], @"");
    STAssertEquals(1, [@"abc" indexOfString:@"b"], @"");
    STAssertEquals(1, [@"abcbbb" indexOfString:@"b"], @"");
    STAssertEquals(-1, [@"" indexOfString:@"b"], @"");
}

- (void)testIndexOfStringFromIndex {
    STAssertEquals(-1, [@"abc" indexOfString:@"dd" fromIndex:0], @"");
    STAssertEquals(1, [@"abc" indexOfString:@"bc" fromIndex:1], @"");
    STAssertEquals(-1, [@"abc" indexOfString:@"bc" fromIndex:2], @"");
    STAssertEquals(3, [@"abcb" indexOfString:@"b" fromIndex:2], @"");
    STAssertEquals(4, [@"abcbbb" indexOfString:@"b" fromIndex:4], @"");
    STAssertEquals(-1, [@"" indexOfString:@"b"], @"");
}

- (void)testLastIndexOfChar {
    STAssertEquals(-1, [@"abc" lastIndexOfChar:'d'], @"");
    STAssertEquals(3, [@"abcb" lastIndexOfChar:'b'], @"");
}

- (void)testLastIndexOfCharFromIndex {
    STAssertEquals(-1, [@"abc" lastIndexOfChar:'d' fromIndex:2], @"");
    STAssertEquals(1, [@"abc" lastIndexOfChar:'b' fromIndex:1], @"");
    STAssertEquals(4, [@"abcbb" lastIndexOfChar:'b' fromIndex:4], @"");
}

- (void)testLastIndexOfString {
    STAssertEquals(-1, [@"abc" lastIndexOfString:@"dd"], @"");
    STAssertEquals(1, [@"abc" lastIndexOfString:@"bc"], @"");
    STAssertEquals(1, [@"abc" lastIndexOfString:@"b"], @"");
    STAssertEquals(5, [@"abcbbb" lastIndexOfString:@"b"], @"");
    STAssertEquals(-1, [@"" lastIndexOfString:@"b"], @"");
}

- (void)testLastIndexOfStringFromIndex {
    STAssertEquals(-1, [@"abc" lastIndexOfString:@"dd" fromIndex:3], @"");
    STAssertEquals(1, [@"abc" lastIndexOfString:@"bc" fromIndex:3], @"");
    STAssertEquals(-1, [@"abc" lastIndexOfString:@"bc" fromIndex:2], @"");
    STAssertEquals(3, [@"abcb" lastIndexOfString:@"b" fromIndex:4], @"");
    STAssertEquals(4, [@"abcbbb" lastIndexOfString:@"b" fromIndex:5], @"");
    STAssertEquals(-1, [@"" lastIndexOfString:@"b"], @"");
}

- (void)testSubstring {
    STAssertEqualObjects(@"aa", [@"aaaa" substringFromIndex:1 toIndex:3], @"");
    STAssertEqualObjects(@"ab", [@"aaba" substringFromIndex:1 toIndex:3], @"");
}

- (void)testToLowerCase {
    STAssertEqualObjects(@"aaaa", [@"aAaa" toLowerCase], @"");
    STAssertEqualObjects(@"ab", [@"AB" toLowerCase], @"");
}

- (void)testToUpperCase {
    STAssertEqualObjects(@"AAAA", [@"aAaa" toUpperCase], @"");
    STAssertEqualObjects(@"AB", [@"aB" toUpperCase], @"");
}

- (void)testTrim {
    STAssertEqualObjects(@"AAAA", [@" AAAA  " trim], @"");
}

- (void)testReplaceAll {
    STAssertEqualObjects(@"hello  ", [@"hello abc abc" replaceAll:@"abc" with:@""], @"");
}

- (void) testSeparateByDecimal {
    STAssertEqualObjects(@"12,345,678", [@"12345678" separateByDecimal], @"");
}

- (void) testGenerateUDID {
    NSLog(@"%s, %@", __FUNCTION__, [NSString generateUDID]);
}

- (void) testTimeStampConvertTime {
    STAssertEqualObjects(@"2014-09-16 19:31:34", [NSString timeStampConvertTime:@"1410867094"], @"");
}

- (void) testcurrentTimeConvertTimeStamp {
    NSLog(@"%s, %@", __FUNCTION__, [NSString currentTimeConvertTimeStamp]);
}

- (void) testTimeConvertTimeStamp {
    STAssertEqualObjects(@"1410867094.000000", [NSString timeConvertTimeStamp:@"2014-09-16 19:31:34"], @"");
}

- (void) testTimeStampConvertToTimeFormat {
    STAssertEqualObjects(@"2014-09-16 19:31:34", [@"1410867094" timeStampConvertToTimeFormat:@"yyyy-MM-dd HH:mm:ss"], @"");
}

- (void) testTimeFormatConvertToTimeStamp {
    STAssertEqualObjects(@"1410867094.000000", [@"2014-09-16 19:31:34" timeFormatConvertToTimeStamp:@"yyyy-MM-dd HH:mm:ss"], @"");
}

- (void) testStringWithDate {
    NSDate *tDate = [NSDate dateWithTimeIntervalSince1970:[@"1410867094.000000" doubleValue]];
    STAssertEqualObjects(@"2014-09-16 19:31:34", [NSString stringWithDate:tDate dateFormat:@"yyyy-MM-dd HH:mm:ss"], @"");
}

- (void) testMd5 {
    STAssertEqualObjects(@"7ac66c0f148de9519b8bd264312c4d64", [@"abcdefg" md5], @"");
}

- (void) testBase64StringFromText {
    STAssertEqualObjects(@"Rm9ycmVzdA==", [NSString base64StringFromText:@"Forrest"], @"");
}

- (void) testTextFromBase64String {
    STAssertEqualObjects(@"Forrest", [NSString textFromBase64String:[NSString base64StringFromText:@"Forrest"]], @"");
}

- (void) testStringURLEncoding {
    STAssertEqualObjects(@"http%3A%2F%2Fwww.cnblogs.com%2Fkesalin%2Farchive%2F2011%2F12%2F23%2Fcocoa_ocunit_ocmock.html",
                         [@"http://www.cnblogs.com/kesalin/archive/2011/12/23/cocoa_ocunit_ocmock.html" stringURLEncoding],
                         @"");
}

- (void) testColorWithHexString {
    UIColor *color = [NSString colorWithHexString:@"#029387" andAlpha:1];
    STAssertTrue([color isKindOfClass:[UIColor class]], @"");
}

@end









