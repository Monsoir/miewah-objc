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
#import "UIConstants.h"
#import "FoundationConstants.h"
#import "MiewahUser.h"
#import "AboutMeViewModel.h"

#import "UINavigationBar+BottomLine.h"

@interface AboutMeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet AvatarHeader *avatarHeader;
@property (nonatomic, weak) IBOutlet Footer *tableFooter;

@property (nonatomic, strong) AboutMeViewModel *vm;

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setupSubviews];
    [self linkSignals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)linkSignals {
    @weakify(self);
    [self.vm.loggedChangedSignal subscribeNext:^(id _Nullable x) {
        @strongify(self);
        [self reloadView];
    }];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar removeBottomLine];
}

- (void)setupSubviews {
    self.tableView.rowHeight = 50;
}

- (void)setupSubviewsForTourist {
    self.avatarHeader.lbName.text = @"游客";
}

- (void)setupSubviewsForRegisteredUser {
    self.avatarHeader.lbName.text = @"扬扬扬";
    self.tableFooter.title = @"登  出";
    self.tableFooter.textColor = UIColor.redColor;
    [self.tableFooter.btnFunction addTarget:self action:@selector(actionLogout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadView {
    void (^reload)(void) = ^void() {
        BOOL logged = [self.vm.logged boolValue];
        self.tableFooter.shouldBeBlank = !logged;
        logged ? [self setupSubviewsForRegisteredUser] : [self setupSubviewsForTourist];
        [self.tableView reloadData];
    };
    runOnMainThread(reload);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.interactiveItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.vm.logged boolValue]) {
        ColorBlockBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ColorBlockBasicTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.colorLeader.backgroundColor = UIColor.redColor;
        cell.lbTitle.text = self.vm.interactiveItems[indexPath.row];
        return cell;
    } else {
        TextAlignCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TextAlignCenterTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.lbTtitle.text = self.vm.interactiveItems[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.vm.logged boolValue]) {
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

- (void)actionLogout {
    [[MiewahUser thisUser] clearUserInfo];
}

- (AboutMeViewModel *)vm {
    if (_vm == nil) {
        _vm = [[AboutMeViewModel alloc] init];
    }
    return _vm;
}

@end
