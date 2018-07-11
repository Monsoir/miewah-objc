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
#import "UIColor+Hex.h"

@interface LocalAssetViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LocalAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubview {
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.edges.equalTo(self.view.safeAreaLayoutGuide);
        } else {
            make.edges.equalTo(self.view.layoutGuides);
        }
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LocalAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LocalAssetCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.item = @"adfa";
    return cell;
}

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        NSArray<NSDictionary *> *cellInfo = @[@{CollectionViewBuilderCellClassKey: [LocalAssetCollectionViewCell class],CollectionViewBuilderCellIdentifierKey:[LocalAssetCollectionViewCell reuseIdentifier]}];
        UICollectionViewFlowLayout *flowLayout = [UIContainerBuilder collectionFlowLayoutWithItemSize:[LocalAssetCollectionViewCell cellSize] scrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [UIContainerBuilder collectionViewOfFlowLayout:flowLayout backgroundColor:[UIColor colorWithHexString:@"#F6F6F6"] cellInfo:cellInfo delegate:self dataSource:self];
    }
    return _collectionView;
}

@end
