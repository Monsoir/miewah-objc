//
//  AssetDetailViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/7.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AssetDetailViewController.h"
#import "CustomAlertController.h"
#import "ShareItemViewController.h"
#import "SystemProvide.h"

@interface AssetDetailViewController ()

@property (nonatomic, strong) UIBarButtonItem *loadingIndicatorItem;
@property (nonatomic, strong) UIBarButtonItem *shareItem;
@property (nonatomic, strong) UIBarButtonItem *favorItem;
@property (nonatomic, strong) UIRefreshControl *tableRefresher;

@end

@implementation AssetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSignals];
    
    // loadData 改为当缓存读取完成后再进行
//    [self.vm loadData];
    [self.vm readFromFavor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", [self class]);
#endif
}

- (void)setInitialInfo:(NSDictionary *)info {}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = self.loadingIndicatorItem;
    self.title = self.vm.asset.item;
}

- (void)setupSubviews {}
- (void)linkSignals {}

- (void)actionShare {
    NSDictionary *shareInfo = @{
                                AssetItemKey: alwaysString(self.vm.asset.item),
                                AssetSentencesKey: alwaysString(self.vm.asset.sentences),
                                AssetMeaningKey: alwaysString(self.vm.asset.meaning),
                                };
    ShareItemViewController *shareVC = [[ShareItemViewController alloc] initWithShareInfo:shareInfo];
    CustomAlertController *alert = [[CustomAlertController alloc] initWithTitle:self.vm.asset.item customViewController:shareVC style:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [shareVC shootViewCompletion:^(UIImage *viewShot) {
            [SystemProvide shareItems:@[viewShot]];
        }];
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)actionToggleCollect {
    self.vm.favored ? [self.vm unfavorAsset] : [self.vm favorAsset];
}

- (void)actionUserRefresh {
    [self.vm loadData];
}

#pragma mark - Accessors

- (UIBarButtonItem *)loadingIndicatorItem {
    if (_loadingIndicatorItem == nil) {
        UIActivityIndicatorView *anIndicator = [[UIActivityIndicatorView alloc] init];
        anIndicator.hidesWhenStopped = YES;
        anIndicator.color = UIColor.darkGrayColor;
        [anIndicator startAnimating];
        _loadingIndicatorItem = [[UIBarButtonItem alloc] initWithCustomView:anIndicator];
    }
    return _loadingIndicatorItem;
}

- (UIBarButtonItem *)shareItem {
    if (_shareItem == nil) {
        _shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionShare)];
    }
    return _shareItem;
}

- (UIBarButtonItem *)favorItem {
    if (_favorItem == nil) {
        _favorItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collect_selected"] style:UIBarButtonItemStylePlain target:self action:@selector(actionToggleCollect)];
    }
    return _favorItem;
}

- (UIRefreshControl *)tableRefresher {
    if (_tableRefresher == nil) {
        _tableRefresher = [[UIRefreshControl alloc] init];
        [_tableRefresher addTarget:self action:@selector(actionUserRefresh) forControlEvents:UIControlEventValueChanged];
    }
    return _tableRefresher;
}

@end
