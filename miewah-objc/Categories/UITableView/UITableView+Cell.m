//
//  UITableView+Cell.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UITableView+Cell.h"

@implementation UITableView (Cell)

- (void)findIndexPathOfCell:(UITableViewCell *)cell then:(foundCellIndexPathDone)done {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath) {
        done(indexPath);
    }
}

@end
