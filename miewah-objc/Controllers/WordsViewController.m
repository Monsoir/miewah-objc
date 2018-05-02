//
//  WordsMieMieViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/27.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsViewController.h"
#import "ShortItemTableViewCell.h"
#import "UIColor+Hex.h"
#import "UINavigationBar+BottomLine.h"

@interface WordsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WordsViewController

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
    [self.navigationController.navigationBar removeBottomLine];
}

- (void)setupSubviews {
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.tableView registerNib:[UINib nibWithNibName:[ShortItemTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShortItemTableViewCell reuseIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showWordDetail" sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource == nil) return 0;
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShortItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    return cell;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    }
    return _dataSource;
}

@end
