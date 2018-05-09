//
//  MiewahListViewController.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundationConstants.h"

@interface MiewahListViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *itemNewOne;
- (void)configureNewOneItem;


/**
 指定新建项目的类型
 
 子类重写此方法，用于指定新建时初始化哪种项目

 @return 返回项目类型
 */
- (MiewahItemType)miewahItemType;

@end
