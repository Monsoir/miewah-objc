//
//  AboutMeViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/25.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "AboutMeViewController.h"
#import "AvatarHeader.h"
#import "Footer.h"
#import "ColorBlockBasicTableViewCell.h"
#import "TextAlignCenterTableViewCell.h"

#import "UINavigationBar+BottomLine.h"

@interface AboutMeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet AvatarHeader *avatarHeader;
@property (nonatomic, weak) IBOutlet Footer *tableFooter;

@property (nonatomic, strong) NSArray<NSString *> *loggeditems;
@property (nonatomic, strong) NSArray<NSString *> *unloggedItems;
@property (nonatomic, assign) BOOL logged;

@end

@implementation AboutMeViewController

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
    self.logged = NO;
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar removeBottomLine];
}

- (void)setupSubviews {
    self.tableView.rowHeight = 50;
    self.tableFooter.shouldBeBlank = !self.logged;
    self.tableFooter.title = @"登  出";
    self.tableFooter.textColor = UIColor.redColor;
    self.logged ? [self setupSubviewsForRegisteredUser] : [self setupSubviewsForTourist];
}

- (void)setupSubviewsForTourist {
    self.avatarHeader.lbName.text = @"游客";
}

- (void)setupSubviewsForRegisteredUser {
    self.avatarHeader.lbName.text = @"扬扬扬";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<NSString *> *items = self.logged ? self.loggeditems : self.unloggedItems;
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.logged) {
        ColorBlockBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ColorBlockBasicTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.colorLeader.backgroundColor = UIColor.redColor;
        cell.lbTitle.text = self.loggeditems[indexPath.row];
        return cell;
    } else {
        TextAlignCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TextAlignCenterTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.lbTtitle.text = self.unloggedItems[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.logged) {
        switch (indexPath.row) {
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"register" sender:nil];
                break;
            case 1:
                [self performSegueWithIdentifier:@"login" sender:nil];
                break;
                
            default:
                break;
        }
    }
}

- (NSArray<NSString *> *)loggeditems {
    if (_loggeditems == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AboutMeLoggedItems" ofType:@"plist"];
        _loggeditems = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _loggeditems;
}

- (NSArray<NSString *> *)unloggedItems {
    if (_unloggedItems == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AboutMeUnloggedItems" ofType:@"plist"];
        _unloggedItems = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _unloggedItems;
}

@end
