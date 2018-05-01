//
//  WordsMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsMieViewController.h"
#import "ShortItemTableViewCell.h"
#import "ListLoadMoreFooterView.h"

#import "UIColor+Hex.h"

@interface WordsMieViewController ()
@end

@interface WordsMieViewController (loadMoreFooter)<ListLoadMoreFooterViewDelegate>
@end

@implementation WordsMieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    [super setupSubviews];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.tableView registerNib:[UINib nibWithNibName:[ShortItemTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShortItemTableViewCell reuseIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 设置 tableview 的下拉刷新
    UIRefreshControl *aRefreshControl = [[UIRefreshControl alloc] init];
    [aRefreshControl addTarget:self action:@selector(actionRefresh:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = aRefreshControl;
    
    // 设置 tableview 最下面的点击加载
    ListLoadMoreFooterView *footer = [[ListLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 50)];
    footer.delegate = self;
    self.tableView.tableFooterView = footer;
}

- (void)actionRefresh:(UIRefreshControl *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender endRefreshing];
    });
}

@synthesize dataSource = _dataSource;

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6]];
    }
    return _dataSource;
}

@end

@implementation WordsMieViewController(loadMoreFooter)

- (void)footerWillLoadMore:(ListLoadMoreFooterView *)footer {
    NSLog(@"loading more...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        footer.status = ListLoadMoreFooterViewStatusNoMore;
    });
}

@end
