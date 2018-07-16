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
    
    JLRoutes *routes = [JLRoutes globalRoutes];
    
    {
        /* character 列表路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper characterListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            [AppTabBarController setSelectedIndex:0];
            return YES;
        }];
        [routes addRoute:route];
    }
    
    {
        /* word 列表路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper wordListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            [AppTabBarController setSelectedIndex:1];
            return YES;
        }];
        [routes addRoute:route];
    }
    
    {
        /* slang 列表路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper slangListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            [AppTabBarController setSelectedIndex:2];
            return YES;
        }];
        [routes addRoute:route];
    }
    
    {
        /* 本地 asset 列表路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper localAssetListRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            [AppTabBarController setSelectedIndex:3];
            return YES;
        }];
        [routes addRoute:route];
    }
}

- (void)configureDetailRoutes {
    
    JLRoutes *routes = [JLRoutes globalRoutes];
    
    UIStoryboard *sb = MainStoryBoard;
    
    void(^ChangeTabIfNeeded)(BOOL, NSInteger) = ^(BOOL doNotChangeTab, NSInteger tabIndex) {
        if (doNotChangeTab == NO) {
            [AppTabBarController setSelectedIndex:tabIndex];
        }
    };
    
    {
        /* character 详情路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper characterDetailRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            
            BOOL doNotChangeTab = [[parameters objectForKey:DoNotChangeTabKey] boolValue];
            ChangeTabIfNeeded(doNotChangeTab, 0);
            
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
        /* word 详情路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper wordDetailRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            
            BOOL doNotChangeTab = [[parameters objectForKey:DoNotChangeTabKey] boolValue];
            ChangeTabIfNeeded(doNotChangeTab, 1);
            
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
        /* slang 详情路由 */
        JLRRouteDefinition *route = [[JLRRouteDefinition alloc] initWithPattern:[RouteHelper slangDetailRoutePattern] priority:0 handlerBlock:^BOOL(NSDictionary * _Nonnull parameters) {
            
            BOOL doNotChangeTab = [[parameters objectForKey:DoNotChangeTabKey] boolValue];
            ChangeTabIfNeeded(doNotChangeTab, 2);
            
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
