//
//  LocalAssetViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/11.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LocalAssetViewController.h"
#import "UIContainerBuilder.h"
#import <Masonry/Masonry.h>
#import "LocalAssetCollectionViewCell.h"
#import "CollectionViewSimpleTextSectionAccessory.h"
#import "UIColor+Hex.h"
#import "LocalAssetListViewModel.h"
#import "UIConstants.h"
#import "AssetDetailViewController.h"
#import "CollectionViewSimpleTextPlaceholderBackgoundView.h"

static NSInteger ListMaxLength = 10;

@interface LocalAssetViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewSimpleTextSectionAccessoryDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIView *headerContainer;
@property (nonatomic, strong) UILabel *lbSectionTitle;
@property (nonatomic, strong) UIButton *btnSectionIndicator;
@property (nonatomic, strong) CollectionViewSimpleTextPlaceholderBackgoundView *placeholderView;
@property (nonatomic, strong) NSDictionary *indicatorEnableAttributes;
@property (nonatomic, strong) NSDictionary *indicatorDisableAttributes;

@property (nonatomic, assign) MiewahItemType type;
@property (nonatomic, strong) LocalAssetListViewModel *vm;
@property (nonatomic, assign) BOOL needSectionFooter;

@end

@implementation LocalAssetViewController

- (instancetype)initWithType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        self.type = type;
        _vm = [[LocalAssetListViewModel alloc] initWithAssetType:type];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubview];
    [self linkSignals];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.vm fetchLocalAsset];
    NSLog(@"%@ did appear", [self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubview {
    [self.view addSubview:self.headerContainer];
    [self.view addSubview:self.collectionView];
    
    [self.headerContainer addSubview:self.lbSectionTitle];
    [self.headerContainer addSubview:self.btnSectionIndicator];
    
    static CGFloat HeaderContainerHeight = 40;
    [self.headerContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.top.equalTo(self.view.safeAreaLayoutGuide);
            make.left.right.equalTo(self.view.safeAreaLayoutGuide);
        } else {
            make.top.equalTo(self.view.layoutGuides);
            make.left.right.equalTo(self.view.layoutGuides);
        }
        make.height.mas_equalTo(HeaderContainerHeight);
    }];
    
    [self.lbSectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerContainer);
        make.leading.equalTo(self.headerContainer).offset(8);
    }];
    
    [self.btnSectionIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerContainer);
        make.trailing.equalTo(self.headerContainer).offset(-8);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerContainer.mas_bottom);
        if (@available(iOS 11, *)) {
            make.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide);
        } else {
            make.left.right.bottom.equalTo(self.view.layoutGuides);
        }
    }];
}

- (void)linkSignals {
    @weakify(self);
    [self.vm.readComplete subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        void(^_)(void) = ^() {
            NSInteger count = self.vm.items.count;
            self.btnSectionIndicator.enabled = count >= ListMaxLength;
            self.collectionView.backgroundView = count > 0 ? nil : self.placeholderView;
            self.needSectionFooter = count >= ListMaxLength;
            [self.collectionView reloadData];
        };
        runOnMainThread(_);
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MiewahAsset *asset = self.vm.items[indexPath.row];
    NSDictionary *userInfo = @{
                               AssetObjectIdKey: alwaysString(asset.objectId),
                               AssetItemKey: alwaysString(asset.item),
                               AssetPronunciationKey: alwaysString(asset.pronunciation),
                               };
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AssetDetailViewController *vc = nil;
    switch (self.type) {
        case MiewahItemTypeCharacter:
            vc = [sb instantiateViewControllerWithIdentifier:@"CharacterDetailViewController"];
            break;
        case MiewahItemTypeWord:
            vc = [sb instantiateViewControllerWithIdentifier:@"WordDetailViewController"];
            break;
        case MiewahItemTypeSlang:
            vc = [sb instantiateViewControllerWithIdentifier:@"SlangDetailViewController"];
            break;
        default:
            break;
    }
    if (vc == nil) return;
    
    [vc setInitialInfo:userInfo];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.vm.items.count >= ListMaxLength ? ListMaxLength + 1 : self.vm.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LocalAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LocalAssetCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    MiewahAsset *asset = self.vm.items[indexPath.row];
    cell.item = asset.item;
    cell.pronunciation = asset.pronunciation;
    cell.meaning = asset.meaning;
    cell.updateAt = [asset normalFormatUpdatedAt];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        CollectionViewSimpleTextSectionAccessory *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[CollectionViewSimpleTextSectionAccessory reuseIdentifier] forIndexPath:indexPath];
        footer.delegate = self;
        footer.title = @"查看更多 >";
        return footer;
    }
    
    return nil;
}

#pragma mark - CollectionViewSimpleTextSectionAccessoryDelegate

- (void)simpleTextSectionAccessoryDidSelect:(CollectionViewSimpleTextSectionAccessory *)accessory {
    NSLog(@"hi");
}

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        NSArray<NSDictionary *> *cellInfo = @[@{CollectionViewBuilderCellClassKey: [LocalAssetCollectionViewCell class],CollectionViewBuilderCellIdentifierKey:[LocalAssetCollectionViewCell reuseIdentifier]}];
        _collectionView = [UIContainerBuilder collectionViewOfFlowLayout:self.flowLayout backgroundColor:[UIColor colorWithHexString:@"#F6F6F6"] cellInfo:cellInfo delegate:self dataSource:self];
        [_collectionView registerClass:[CollectionViewSimpleTextSectionAccessory class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[CollectionViewSimpleTextSectionAccessory reuseIdentifier]];
        _collectionView.alwaysBounceHorizontal = YES;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [UIContainerBuilder collectionFlowLayoutWithItemSize:[LocalAssetCollectionViewCell cellSize] scrollDirection:UICollectionViewScrollDirectionHorizontal];
        _flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    }
    return _flowLayout;
}

- (void)setNeedSectionFooter:(BOOL)needSectionFooter {
    _needSectionFooter = needSectionFooter;
    self.flowLayout.footerReferenceSize = CGSizeMake(_needSectionFooter ? 100 : 0, 100);
}

- (UIView *)headerContainer {
    if (_headerContainer == nil) {
        _headerContainer = [[UIView alloc] init];
    }
    return _headerContainer;
}

- (UILabel *)lbSectionTitle {
    if (_lbSectionTitle == nil) {
        _lbSectionTitle = [[UILabel alloc] init];
        _lbSectionTitle.text = [self.vm sectionTitle];
        _lbSectionTitle.font = [UIFont systemFontOfSize:30];
    }
    return _lbSectionTitle;
}

- (UIButton *)btnSectionIndicator {
    if (_btnSectionIndicator == nil) {
        _btnSectionIndicator = [UIButton buttonWithType:UIButtonTypeSystem];
        static NSString *title = @"查看更多 >";
        NSAttributedString *enabledAttributedTitle = [[NSAttributedString alloc] initWithString:title attributes:self.indicatorEnableAttributes];
        NSAttributedString *disabledAttributedTitle = [[NSAttributedString alloc] initWithString:title attributes:self.indicatorDisableAttributes];
        [_btnSectionIndicator setAttributedTitle:enabledAttributedTitle forState:UIControlStateNormal];
        [_btnSectionIndicator setAttributedTitle:disabledAttributedTitle forState:UIControlStateDisabled];
        _btnSectionIndicator.enabled = NO;
    }
    return _btnSectionIndicator;
}

- (NSDictionary *)indicatorEnableAttributes {
    if (_indicatorEnableAttributes == nil) {
        _indicatorEnableAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Ultralight" size:18],
                                       NSForegroundColorAttributeName: [UIColor blackColor],
                                       };
    }
    return _indicatorEnableAttributes;
}

- (NSDictionary *)indicatorDisableAttributes {
    if (_indicatorDisableAttributes == nil) {
        _indicatorDisableAttributes = @{
                                        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Ultralight" size:18],
                                        NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                        };
    }
    return _indicatorDisableAttributes;
}

- (CollectionViewSimpleTextPlaceholderBackgoundView *)placeholderView {
    if (_placeholderView == nil) {
        static NSString *titleForCharacter = @"还没收藏关于「字」的内容";
        static NSString *titleForWord = @"还没收藏关于「词」的内容";
        static NSString *titleForSlang = @"还没收藏关于「短语」的内容";
        NSString *title = nil;
        switch (self.type) {
            case MiewahItemTypeCharacter:
                title = titleForCharacter;
                break;
            case MiewahItemTypeWord:
                title = titleForWord;
                break;
            case MiewahItemTypeSlang:
                title = titleForSlang;
                break;
            default:
                break;
        }
        _placeholderView = [[CollectionViewSimpleTextPlaceholderBackgoundView alloc] initWithTitle:title];
    }
    return _placeholderView;
}

@end
