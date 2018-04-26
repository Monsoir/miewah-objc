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

typedef enum : NSUInteger {
    SectionIndexMie,
    SectionIndexMieMie,
} SectionIndex;

@interface WordsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *sectionSegmentedControl;

@property (nonatomic, assign) SectionIndex sectionIndex;
@property (nonatomic, strong) NSMutableArray *mieWords;
@property (nonatomic, strong) NSMutableArray *miemieWords;
@property (nonatomic, weak) NSMutableArray *words;
@property (nonatomic, assign) SectionIndex currentSection;

@end

@implementation WordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self setupNavigationBar];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialize {
    self.words = nil;
    self.currentSection = SectionIndexMie;
}

- (void)setupNavigationBar {
    
}

- (void)setupSubviews {
    
    // table view
    self.tableView.rowHeight = 450;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.tableView registerNib:[UINib nibWithNibName:[ShortItemTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShortItemTableViewCell reuseIdentifier]];
    
    // segmented control
    self.currentSection = SectionIndexMie;
}

- (IBAction)actionSectionChanged:(UISegmentedControl *)sender {
    self.currentSection = sender.selectedSegmentIndex;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showWordDetail" sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.words == nil) return 0;
    
    return self.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShortItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    return cell;
}

- (void)setWords:(NSMutableArray *)words {
    _words = words;
    if (_words == nil) return;
    
    UITableViewCell *firstVisibleCell = [self.tableView.visibleCells firstObject];
    if (firstVisibleCell == nil) return;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:firstVisibleCell];
    NSIndexPath *destIndexPath = indexPath.row >= _words.count ? [NSIndexPath indexPathForRow:_words.count - 1 inSection:0] : indexPath;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:destIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
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

- (void)setCurrentSection:(SectionIndex)currentSection {
    _currentSection = currentSection;
    self.words = self.currentSection == SectionIndexMie ? self.mieWords : self.miemieWords;
}

@end
