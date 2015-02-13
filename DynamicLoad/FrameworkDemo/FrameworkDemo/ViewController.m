//
//  ViewController.m
//  FrameworkDemo
//
//  Created by wangzz on 14-6-9.
//  Copyright (c) 2014年 FOOGRY. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import "FWBaseObject.h"

/*
 使用方式：
 将Dylib.framework 和new下的文件放到下面目录即可动态加载
    /Users/.../Library/Developer/CoreSimulator/Devices/DE0C16EF-CEE5-460B-80D6-73A2269238E1/data/Containers/Data/Application/1633CA21-0604-41E3-85E4-F814EF2BC1B7/Documents/
 */

static void *libHandle = NULL;

@interface ViewController ()
{
    NSString    *_libPath;
}

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action
- (IBAction)onTriggerButtonAction:(id)sender
{
    Class rootClass = NSClassFromString(@"Person");
    if (rootClass) {
        FWBaseObject *object = [[rootClass alloc] init];
        [object run];
        [object print];
    }
}

- (IBAction)onBundleLoadAtPathAction1:(id)sender
{
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/Dylib.framework", NSHomeDirectory()];
    [self bundleLoadDylibWithPath:documentsPath];
}

- (IBAction)onBundleLoadAtPathAction2:(id)sender
{
    NSString *newPath = [NSString stringWithFormat:@"%@/Documents/new/Dylib.framework", NSHomeDirectory()];
    [self bundleLoadDylibWithPath:newPath];
}

- (IBAction)onDlopenLoadAtPathAction1:(id)sender
{
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/Dylib.framework/Dylib", NSHomeDirectory()];
    [self dlopenLoadDylibWithPath:documentsPath];
}

- (IBAction)onDlopenLoadAtPathAction2:(id)sender
{
    NSString *newPath = [NSString stringWithFormat:@"%@/Documents/new/Dylib.framework/Dylib", NSHomeDirectory()];
    [self dlopenLoadDylibWithPath:newPath];
}

- (IBAction)onBundleUnloadAction:(id)sender
{
    [self bundleUnloadDylibWithPath:_libPath];
}

- (IBAction)onDlopenUnloadAction:(id)sender
{
    [self dlopenUnloadDylibWithHandle:libHandle];
}

#pragma mark - Private Method
- (void)bundleLoadDylibWithPath:(NSString *)path
{
    _libPath = path;
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
}

- (void)dlopenLoadDylibWithPath:(NSString *)path
{
    libHandle = NULL;
    libHandle = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
}

- (BOOL)bundleUnloadDylibWithPath:(NSString *)path
{
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    BOOL result = [bundle unload];
    if (!result) {
        NSLog(@"bundle unload dylib failed:%@",path);
    } else {
        NSLog(@"bundle unload dylib success");
        path = nil;
    }
    
    return result;
}

- (BOOL)dlopenUnloadDylibWithHandle:(void *)handle
{
    BOOL result = dlclose(handle);
    if (!result) {
        NSLog(@"dlopen unload dylib failed.");
    } else {
        NSLog(@"dlopen unload dylib success");
        handle = NULL;
    }
    
    return result;
}

@end
