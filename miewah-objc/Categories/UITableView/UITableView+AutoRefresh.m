//
//  UITableView+AutoRefresh.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UITableView+AutoRefresh.h"

@implementation UITableView (AutoRefresh)

- (void)refresh {
    [self setContentOffset:CGPointMake(0, self.contentOffset.y - self.refreshControl.frame.size.height / 2) animated:YES];
    [self.refreshControl beginRefreshing];
}

@end
