//
//  ViewController.m
//  05-手势解锁
//
//  Created by JackMeng on 2016/11/10.
//  Copyright © 2016年 JackMeng. All rights reserved.
//

#import "ViewController.h"
#import "HMUnlockView.h"
#import "SVProgressHUD.h"
#import "HMMainViewController.h"

@interface ViewController ()<HMUnlockViewDelegate>
@property (weak, nonatomic) IBOutlet HMUnlockView *unLockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    self.unLockView.delegate = self;
}
- (BOOL)unlockView:(HMUnlockView *)unlockView withPwd:(NSString *)pwd
{
    if ([pwd isEqualToString:@"012"])
    {
        HMMainViewController * mainVC = [[HMMainViewController alloc] init];
        
        mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:mainVC animated:YES completion:nil];
        
        
        return YES;
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"手势错误!"];
        return NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
