//
//  AppDelegate.m
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-19.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "CartViewController.h"
#import "MyAccountViewController.h"
#import "MoreViewController.h"
#import "YWTabBarViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    CategoryViewController *categoryVC = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    CartViewController *cartVC = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
    MyAccountViewController *accoutVC = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
    MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:cartVC];
    UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:accoutVC];
    UINavigationController *navi5 = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
//    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_homepage_unsel.png"]  selectedImage:[UIImage imageNamed:@"tabbar_homepage_sel.png"]];
//    navi1.tabBarItem = homeItem;
    
//    UITabBarItem *categoryItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@""]  selectedImage:[UIImage imageNamed:@""]];
//    UITabBarItem *cartItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""]  selectedImage:[UIImage imageNamed:@""]];
//    UITabBarItem *accountItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""]  selectedImage:[UIImage imageNamed:@""]];
//    UITabBarItem *moreItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""]  selectedImage:[UIImage imageNamed:@""]];
//    
    
    
    YWTabBarViewController *tabbarVC = [[YWTabBarViewController alloc] init];
    tabbarVC.viewControllers = @[navi1,navi2,navi3,navi4,navi5];
    tabbarVC.delegate = self;
    self.window.rootViewController = tabbarVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods
- (void)tabBarController:(UITabBarController *)tabBar didSelectViewController:(UIViewController *)viewController
{
    YWTabBarViewController *ywTab = (YWTabBarViewController *)tabBar;
    
    NSInteger index = [tabBar.viewControllers indexOfObject:viewController];
    
    [ywTab selectItemAtIndex:index];
    

}

@end
