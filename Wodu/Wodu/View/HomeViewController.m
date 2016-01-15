//
//  HomeViewController.m
//  Wodu
//
//  Created by tenny on 15/12/24.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"
#import "ReadViewController.h"
#import "ListenViewController.h"
#import "MyViewController.h"
#import "Defines.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initTabBar];
    
    

}


- (void) initTabBar {
//    self.tabBar.hidden = true;
//    self.bottomTabView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - HomeTabViewHeight, ScreenWidth, HomeTabViewHeight)];
//    
//    [self.bottomTabView setBackgroundColor:[UIColor redColor]];
//    
//    
//    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"TabBarItem" ofType:@"plist"];
//    NSArray *pageConfigs = [NSArray arrayWithContentsOfFile:configFile];
//    
//
//    [self.view addSubview:self.bottomTabView];
//    NewsViewController *news = [[NewsViewController alloc] init];
//    ReadViewController *read = [[ReadViewController alloc] init];
//    ListenViewController *listen = [[ListenViewController alloc] init];
//    MyViewController *my = [[MyViewController alloc] init];
//    NSArray *controllers = @[news, read, listen, my];
    
    
    // get tabbar config from file
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"TabBarItem" ofType:@"plist"];
    NSArray *pageConfigs = [NSArray arrayWithContentsOfFile:configFile];
    
    // nav array
    NSMutableArray *navs = [[NSMutableArray alloc] initWithCapacity:pageConfigs.count];
    
    
    // tabbar title color
    NSDictionary *titleColor = [NSDictionary dictionaryWithObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    NSDictionary *titleSelectColor = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    
    
    for (int i = 0; i < pageConfigs.count; i++) {
        NSDictionary *dic = pageConfigs[i];
        
        // if the controller is show
        if (![dic objectForKey:@"isShow"]) {
            UIViewController *vc = [[NSClassFromString(dic[@"ID"]) alloc] init];
            vc.tabBarItem.title = dic[@"Title"];
//            vc.tabBarItem set
            [vc.tabBarItem setTitleTextAttributes:titleColor forState:UIControlStateNormal];
            [vc.tabBarItem setTitleTextAttributes:titleSelectColor forState:UIControlStateSelected];
            vc.tabBarItem.image = [UIImage imageNamed:dic[@"Image"]];
            UIImage *img = [UIImage imageNamed:dic[@"SelectImage"]];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.selectedImage = img;
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0); // todo
            vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            [navs addObject:nav];
        }
        
    }
    
    self.viewControllers = navs;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
