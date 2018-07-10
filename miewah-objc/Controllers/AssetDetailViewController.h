//
//  AssetDetailViewController.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/7.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiewahDetailViewModel.h"

@interface AssetDetailViewController : UIViewController

@property (nonatomic, strong, readonly) MiewahDetailViewModel *vm;
@property (nonatomic, strong, readonly) UIBarButtonItem *loadingIndicatorItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *shareItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *favorItem;

- (void)setInitialInfo:(NSDictionary *)info;
- (void)setupNavigationBar;
- (void)setupSubviews;
- (void)linkSignals;
- (void)actionShare;

@end
