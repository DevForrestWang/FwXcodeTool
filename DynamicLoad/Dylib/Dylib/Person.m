//
//  Person.m
//  Dylib
//
//  Created by wangzz on 14-6-9.
//  Copyright (c) 2014年 FOOGRY. All rights reserved.
//

#import "Person.h"
#import <UIKit/UIKit.h>

@implementation Person

- (void)run
{
    NSLog(@"Person, %s, run.", __FUNCTION__);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The Second Alert"
                                                    message:nil delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"done", nil];
    [alert show];
}

- (void)print
{
    NSLog(@"Person, %s, print.", __FUNCTION__);
}
@end
