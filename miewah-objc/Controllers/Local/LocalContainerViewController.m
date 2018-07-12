//
//  LocalViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/11.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LocalContainerViewController.h"
#import <Masonry/Masonry.h>
#import "LocalAssetViewController.h"
#import "UIColor+Hex.h"
#import "UIViewController+NavigationItem.h"

@interface LocalContainerViewController ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) LocalAssetViewController *characterVC;
@property (nonatomic, strong) LocalAssetViewController *wordVC;
@property (nonatomic, strong) LocalAssetViewController *slangVC;

@end

@implementation LocalContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    self.title = @"本地收藏";
    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    [self removeBackButtonItemTitle];
}

- (void)setupSubviews {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    [self addChildViewController:self.characterVC];
    [self addChildViewController:self.wordVC];
    [self addChildViewController:self.slangVC];
    
    // 初始化各种 view
    UIScrollView *backingScrollView = [[UIScrollView alloc] init];
    NSArray *views = @[self.characterVC.view, self.wordVC.view, self.slangVC.view];
    
    // 添加各种 view
    [self.view addSubview:backingScrollView];
    [backingScrollView addSubview:self.container];
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.container addSubview:obj];
    }];
    
    // 对各种 view 添加约束
    
    [backingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.edges.equalTo(self.view.safeAreaLayoutGuide);
        } else {
            make.edges.equalTo(self.view.layoutGuides);
        }
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backingScrollView);
        make.width.equalTo(backingScrollView);
    }];
    
    UIView *lastView = nil;
    static CGFloat CollectionViewHeight = 250;
    for (UIView *childView in views) {
        [childView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CollectionViewHeight);
            make.left.right.equalTo(self.container);
            if (lastView == nil) {
                make.top.equalTo(self.container);
            } else {
                make.top.equalTo(lastView.mas_bottom).offset(10);
            }
        }];
        lastView = childView;
    }
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView);
    }];
    
    [self.characterVC didMoveToParentViewController:self];
    [self.wordVC didMoveToParentViewController:self];
    [self.slangVC didMoveToParentViewController:self];
}

#pragma mark - Accessors

- (UIView *)container {
    if (_container == nil) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    }
    return _container;
}

- (LocalAssetViewController *)characterVC {
    if (_characterVC == nil) {
        _characterVC = [[LocalAssetViewController alloc] initWithType:MiewahItemTypeCharacter];
    }
    return _characterVC;
}

- (LocalAssetViewController *)wordVC {
    if (_wordVC == nil) {
        _wordVC = [[LocalAssetViewController alloc] initWithType:MiewahItemTypeWord];
    }
    return _wordVC;
}

- (LocalAssetViewController *)slangVC {
    if (_slangVC == nil) {
        _slangVC = [[LocalAssetViewController alloc] initWithType:MiewahItemTypeSlang];
    }
    return _slangVC;
}

@end
