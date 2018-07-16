//
//  AppDelegate+Routes.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/16.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AppDelegate+Routes.h"
#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteDefinition.h>
#import "RouteHelper.h"
#import "FoundationConstants.h"
#import "UIConstants.h"
#import "AssetDetailViewController.h"

#define AppTabBarController ((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController)
#define AppCurrentNavigationController (UINavigationController *)[AppTabBarController selectedViewController]

@implementation AppDelegate (Routes)

- (void)configureRoutes {
    [self configureListRoutes];
    [self configureDetailRoutes];
}

- (void)configureListRoutes {
    
    JLRRouteDefinition *characterListRoute = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper characterListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
        [AppTabBarController setSelectedIndex:0];
        return YES;
    }];
    
    JLRRouteDefinition *wordListRoute = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper wordListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
        [AppTabBarController setSelectedIndex:1];
        return YES;
    }];
    
    JLRRouteDefinition *slangListRoute = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper slangListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
        [AppTabBarController setSelectedIndex:2];
        return YES;
    }];
    
    JLRoutes *routes = [JLRoutes globalRoutes];
    [routes addRoute:characterListRoute];
    [routes addRoute:wordListRoute];
    [routes addRoute:slangListRoute];
}

- (void)configureDetailRoutes {
    
    JLRoutes *routes = [JLRoutes globalRoutes];
    
    UIStoryboard *sb = MainStoryBoard;
    
    {
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper characterDetailRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            [AppTabBarController setSelectedIndex:0];
            
            NSDictionary *userInfo = @{
                                       AssetItemKey: alwaysString([parameters objectForKey:AssetItemKey]),
                                       AssetPronunciationKey: alwaysString([parameters objectForKey:AssetPronunciationKey]),
                                       AssetObjectIdKey: alwaysString([parameters objectForKey:AssetObjectIdKey])
                                       };
            AssetDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"CharacterDetailViewController"];
            [vc setInitialInfo:userInfo];
            [AppCurrentNavigationController pushViewController:vc animated:YES];
            
            return YES;
        }];
        [routes addRoute:route];
    }
    
    {
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper wordDetailRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            
            [AppTabBarController setSelectedIndex:1];
            
            NSDictionary *userInfo = @{
                                       AssetItemKey: alwaysString([parameters objectForKey:AssetItemKey]),
                                       AssetPronunciationKey: alwaysString([parameters objectForKey:AssetPronunciationKey]),
                                       AssetObjectIdKey: alwaysString([parameters objectForKey:AssetObjectIdKey])
                                       };
            AssetDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WordDetailViewController"];
            [vc setInitialInfo:userInfo];
            [AppCurrentNavigationController pushViewController:vc animated:YES];
            
            return YES;
        }];
        [routes addRoute:route];
    }
    
    {
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper slangDetailRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            
            [AppTabBarController setSelectedIndex:2];
            
            NSDictionary *userInfo = @{
                                       AssetItemKey: alwaysString([parameters objectForKey:AssetItemKey]),
                                       AssetPronunciationKey: alwaysString([parameters objectForKey:AssetPronunciationKey]),
                                       AssetObjectIdKey: alwaysString([parameters objectForKey:AssetObjectIdKey])
                                       };
            AssetDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SlangDetailViewController"];
            [vc setInitialInfo:userInfo];
            [AppCurrentNavigationController pushViewController:vc animated:YES];
            
            return YES;
        }];
        [routes addRoute:route];
    }
}

@end
