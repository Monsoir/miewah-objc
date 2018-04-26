//
//  WordDetailViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordDetailViewController.h"

#import "ItemIntroductionCell.h"

static NSString *SectionIdentifier = @"section-header";

@interface WordDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *sectionNames;

@end

@implementation WordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:SectionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:[ItemIntroductionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ItemIntroductionCell reuseIdentifier]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionIdentifier];
    header.textLabel.text = self.sectionNames[section];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sectionNames == nil) return 0;
    return self.sectionNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemIntroductionCell reuseIdentifier] forIndexPath:indexPath];
    cell.lbIntroductions.text = @"dkldfjw;dh;jdksajf;kfnerifwnk;adsn;fna;fnskdajmlakjsdvdn,asksmca";
    return cell;
}

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WordDetailSections" ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _sectionNames;
}

@end
