//
//  AppDelegate.m
//  MRC
//
//  Created by 苏沫离 on 2020/4/24.
//  Copyright © 2020 苏沫离. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    [self.window makeKeyAndVisible];
    
    ViewController *vc = [[[ViewController alloc] init] autorelease];
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    self.window.rootViewController = nav;
    return YES;
}

@end
