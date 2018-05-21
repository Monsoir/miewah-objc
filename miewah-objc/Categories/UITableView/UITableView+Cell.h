//
//  UITableView+Cell.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^foundCellIndexPathDone)(NSIndexPath *indexPath);

@interface UITableView (Cell)

- (void)findIndexPathOfCell:(UITableViewCell *)cell then:(foundCellIndexPathDone)done;

@end
