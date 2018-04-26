//
//  SlangsViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangsViewController.h"

#import "ShortItemTableViewCell.h"

#import "UIColor+Hex.h"

@interface SlangsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *slangs;

@end

@implementation SlangsViewController

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
    
}

- (void)setupSubviews {
    self.tableView.rowHeight = 450;
    self.tableView.backgroundColor = [UIColor colorWithHexString: @"f6f6f6"];
    [self.tableView registerNib:[UINib nibWithNibName:[ShortItemTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShortItemTableViewCell reuseIdentifier]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showSlangDetail" sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.slangs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShortItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShortItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.lbWord.text = @"惦过碌蔗";
    cell.lbPronounce.text = @"dian4 guo4 lu4 ze4";
    cell.lbMeaning.text = @"很好";
    return cell;
}

- (NSMutableArray *)slangs {
    if (_slangs == nil) {
        _slangs = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6]];
    }
    return _slangs;
}

@end
