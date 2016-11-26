//
//  HMMainViewController.m
//  05-手势解锁
//
//  Created by JackMeng on 2016/11/10.
//  Copyright © 2016年 JackMeng. All rights reserved.
//

#import "HMMainViewController.h"

@interface HMMainViewController ()

@end

@implementation HMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"main"].CGImage);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
