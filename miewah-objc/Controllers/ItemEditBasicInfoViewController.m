//
//  ItemEditBasicInfoViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ItemEditBasicInfoViewController.h"
#import "TextTableViewCell.h"
#import "EditBasicInfoViewModel.h"

#import "UIColor+Hex.h"
#import "UIView+Layout.h"
#import "UITableView+Cell.h"

@interface ItemEditBasicInfoViewController ()<UITableViewDelegate, UITableViewDataSource, TextTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSLayoutConstraint *> *constraints;

@property (nonatomic, strong) EditBasicInfoViewModel *vm;
@property (nonatomic, assign) MiewahItemType type;

@end

@implementation ItemEditBasicInfoViewController

- (instancetype)initWithType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    [self setupSubviews];
    [self linkSignals];
    [self setupNotification];
    [[NSNotificationCenter defaultCenter] postNotificationName:EditAssetToExtraInfosEnableNotificationName
                                                        object:nil
                                                      userInfo:@{
                                                                 EditAssetToExtraInfosEnableNotificationUserInfoKey: @(NO),
                                                                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@: deallocs", [self class]);
#endif
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:self.constraints];
}

- (void)linkSignals {
    [self.vm.enableNextSignal subscribeNext:^(NSNumber * _Nullable x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:EditAssetToExtraInfosEnableNotificationName
                                                            object:nil
                                                          userInfo:@{
                                                                     EditAssetToExtraInfosEnableNotificationUserInfoKey: x,
                                                                     }];
    }];
}

- (void)setupNotification {
    @weakify(self);
    [DefaultNotificationCenter addObserverForName:EditAssetResetNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self);
        NSDictionary *userInfo = note.userInfo;
        MiewahItemType type = [userInfo[EditAssetResetTypeNotificationUserInfoKey] unsignedIntegerValue];
        if (type != self.type) return;
        
        [self.vm readBasicInfos];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.sectionNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TextTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    NSString *prompt = self.vm.sectionNames[indexPath.row];
    cell.lbTextPrompt.text = prompt;
    cell.tfContent.placeholder = @"在此输入内容";
    cell.delegate = self;
    
    switch (indexPath.row) {
        case 0:
            cell.tfContent.text = self.vm.item;
            break;
        case 1:
            cell.tfContent.text = self.vm.pronunonciation;
            break;
        case 2:
            cell.tfContent.text = self.vm.meaning;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)textTableViewCellTextDidChange:(TextTableViewCell *)cell text:(NSString *)text {
    [self.tableView findIndexPathOfCell:cell then:^(NSIndexPath *indexPath) {
        switch (indexPath.row) {
            case 0:
                self.vm.item = text;
                break;
            case 1:
                self.vm.pronunonciation = text;
                break;
            case 2:
                self.vm.meaning = text;
                break;
            default:
                break;
        }
    }];
}

#pragma mark - Accessors

- (EditBasicInfoViewModel *)vm {
    if (_vm == nil) {
        _vm = [[EditBasicInfoViewModel alloc] initWithType:self.type];
    }
    return _vm;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:[TextTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TextTableViewCell reuseIdentifier]];
        
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSArray<NSLayoutConstraint *> *)constraints {
    if (_constraints == nil) {
        _constraints = [self.tableView fullLayoutConstraintsToParentView:self.view];
    }
    return _constraints;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
