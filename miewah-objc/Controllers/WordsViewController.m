//
//  WordsViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsViewController.h"
#import "ShortItemTableViewCell.h"

#import "UIColor+Hex.h"
#import "UINavigationBar+BottomLine.h"

@interface WordsViewController ()

@property (nonatomic, strong) NSMutableArray *mieWords;
@property (nonatomic, strong) NSMutableArray *miemieWords;

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

- (NSMutableArray *)mieWords {
    if (_mieWords == nil) {
        _mieWords = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6]];
    }
    return _mieWords;
}

- (NSMutableArray *)miemieWords {
    if (_miemieWords == nil) {
        _miemieWords = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    }
    return _miemieWords;
}

@end
