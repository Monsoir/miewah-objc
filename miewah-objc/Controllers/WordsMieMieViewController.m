//
//  WordsMieMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsMieMieViewController.h"
#import "ShortItemTableViewCell.h"
#import "UIColor+Hex.h"

@interface WordsMieMieViewController ()

@end

@implementation WordsMieMieViewController

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
}

@synthesize dataSource = _dataSource;

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    }
    return _dataSource;
}

@end
