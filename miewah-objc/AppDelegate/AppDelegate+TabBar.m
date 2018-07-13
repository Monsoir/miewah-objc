//
//  AppDelegate+TabBar.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AppDelegate+TabBar.h"
#import "LocalContainerViewController.h"
#import "UINavigationBar+BottomLine.h"

@implementation AppDelegate (TabBar)

- (UITabBarController *)configureTabBarStuff {
    
    UITabBarController *tvc = [[UITabBarController alloc] init];
    NSArray *viewControllers = [self tabs];
    tvc.viewControllers = viewControllers;
    return tvc;
}

- (NSArray<UINavigationController *> *)tabs {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *characterNC = [[self class] navigationViewControllerFromStoryboard:sb identifier:@"CharacterNC"];
    [[self class] configureViewController:characterNC tabBarImage:[UIImage imageNamed:@"tab-bar-character"] selected:[UIImage imageNamed:@"tab-bar-character-selected"]];
    
    UINavigationController *wordNC = [[self class] navigationViewControllerFromStoryboard:sb identifier:@"WordNC"];
    [[self class] configureViewController:wordNC tabBarImage:[UIImage imageNamed:@"tab-bar-word"] selected:[UIImage imageNamed:@"tab-bar-word-selected"]];
    
    UINavigationController *slangNC = [[self class] navigationViewControllerFromStoryboard:sb identifier:@"SlangNC"];
    [[self class] configureViewController:slangNC tabBarImage:[UIImage imageNamed:@"tab-bar-slang"] selected:[UIImage imageNamed:@"tab-bar-slang-selected"]];
    
//    UINavigationController *mineNC = [[self class] navigationViewControllerFromStoryboard:sb identifier:@"MineNC"];
//    [[self class] configureViewController:mineNC tabBarImage:[UIImage imageNamed:@"tab-bar-mine"] selected:[UIImage imageNamed:@"tab-bar-mine-selected"]];
    
    LocalContainerViewController *localVC = [[LocalContainerViewController alloc] init];
    UINavigationController *localNC = [[UINavigationController alloc] initWithRootViewController:localVC];
    [[self class] configureViewController:localNC tabBarImage:[UIImage imageNamed:@"tab-bar-local"] selected:[UIImage imageNamed:@"tab-bar-local-selected"]];
    [localNC.navigationBar removeBottomLine];
    
    return @[
             characterNC,
             wordNC,
             slangNC,
//             mineNC,
             localNC,
             ];
}

+ (UINavigationController *)navigationViewControllerFromStoryboard:(UIStoryboard *)sb identifier:(NSString *)identifier {
    UINavigationController *nc = [sb instantiateViewControllerWithIdentifier:identifier];
    [nc.navigationBar removeBottomLine];
    return nc;
}

+ (void)configureViewController:(UIViewController *)vc tabBarImage:(UIImage *)image selected:(UIImage *)selectedImage {
    vc.tabBarItem.title = nil;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
