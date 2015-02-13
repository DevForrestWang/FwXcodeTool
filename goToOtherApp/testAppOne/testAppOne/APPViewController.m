//
//  APPViewController.m
//  testAppOne
//
//  Created by 千落 on 15/2/5.
//  Copyright (c) 2015年 千落. All rights reserved.
//

#import "APPViewController.h"

#define HEIGHT [UIScreen mainScreen].applicationFrame.size.height
#define WIDTH [UIScreen mainScreen].applicationFrame.size.width

@interface APPViewController ()<UIAlertViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) UILabel *testLabel1;
@property (nonatomic, strong) UILabel *testLabel2;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation APPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, HEIGHT/4 + 20, WIDTH - 140, 30)];
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"请输入文字";
    self.textField.adjustsFontSizeToFitWidth = YES;
    self.textField.enabled = YES;
    self.textField.clearsOnBeginEditing = YES;
    [self.view addSubview:self.textField];
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT/4 - 20)];
    self.testLabel.font = [UIFont systemFontOfSize:50];
    self.testLabel.textColor = [UIColor whiteColor];
    self.testLabel.backgroundColor = [UIColor purpleColor];
    self.testLabel.numberOfLines = 0;
    [self.view addSubview:self.testLabel];
    
    self.testLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, HEIGHT/4 + 60, WIDTH - 40, HEIGHT/4 - 20)];
    self.testLabel1.font = [UIFont systemFontOfSize:20];
    self.testLabel1.backgroundColor = [UIColor cyanColor];
    self.testLabel1.textColor = [UIColor blueColor];
    self.testLabel1.text = @"点击上方紫色按钮，可把textField输入的字符串，传递到testAppTwo里面。前提需要把testAppOne、testAppTwo都运行在模拟机或真机上。";
    self.testLabel1.numberOfLines = 0;
    [self.view addSubview:self.testLabel1];
    
    self.testLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, HEIGHT/2 + 100, WIDTH - 40, HEIGHT/2 - 100)];
    self.testLabel2.backgroundColor = [UIColor cyanColor];
    self.testLabel2.font = [UIFont systemFontOfSize:20];
    self.testLabel2.text = @"点击上方蓝色按钮，会在本机寻找微信APP，如果没有寻找到，   会有弹窗提示，是否跳转App Store下载。";
    self.testLabel2.textColor = [UIColor blueColor];
    self.testLabel2.numberOfLines = 0;
    [self.view addSubview:self.testLabel2];
    
    UIButton *btnApp = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 120, HEIGHT/4 + 20, 100, 30)];
    btnApp.backgroundColor = [UIColor purpleColor];
    [btnApp setTitle:@"testAppTwo" forState:UIControlStateNormal];
    [btnApp addTarget:self action:@selector(testApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnApp];
    
    UIButton *btnAppstore = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 120, HEIGHT/2 + 50, 100, 30)];
    btnAppstore.backgroundColor = [UIColor blueColor];
    [btnAppstore setTitle:@"微信" forState:UIControlStateNormal];
    [btnAppstore addTarget:self action:@selector(testAppstore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAppstore];
}

- (void)testApp
{
    [self.view endEditing:YES];
    [self textFieldDidEndEditing:self.textField];
    
    //执行openURL 跳转APP
    NSString *str = [NSString stringWithFormat:@"testAppTwo://com.lakala.MeiChi?name=%@",self.textField.text];
    NSURL *myURL_APP_A = [NSURL URLWithString: [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:myURL_APP_A];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"停止输入");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)testAppstore
{
    NSURL *myURl_APP_B = [NSURL URLWithString:@"aa:"];
    
    //如果Open成功，执行openURL，跳转APP
    if ([[UIApplication sharedApplication] openURL:myURl_APP_B]) {
        [[UIApplication sharedApplication] openURL:myURl_APP_B];
    }
    else{
        //添加提示框
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"本手机上没有找到该APP是否跳转appstore" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
        [sheet showInView:self.view];
    }
}

//监听ActionSheet按钮
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //跳转Appstore下载
        NSURL *myURL_APPSTORE = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"];
        [[UIApplication sharedApplication] openURL:myURL_APPSTORE];
    }
    else if (buttonIndex == 1) {
        NSLog(@"取消");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
