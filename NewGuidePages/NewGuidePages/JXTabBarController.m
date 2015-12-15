//
//  JXTabBarController.m
//  NewGuidePages
//
//  Created by 白金星 on 15/12/15.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXTabBarController.h"

@interface JXTabBarController ()

@end

@implementation JXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIViewController *home = [self loadViewControllerWithSBName:@"Main"];
    

    self.viewControllers = @[home];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController*)loadViewControllerWithSBName:(NSString*)name
{
    // 获取sb对象
    UIStoryboard* sb = [UIStoryboard storyboardWithName:name bundle:nil];

    // 获取箭头所指向的控制器
    return sb.instantiateInitialViewController;
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
