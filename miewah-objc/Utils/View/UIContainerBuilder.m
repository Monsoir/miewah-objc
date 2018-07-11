//
//  TableViewBuilder.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/11.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIContainerBuilder.h"

NSString * TableViewBuilderCellClassKey = @"TableViewBuilderCellClassKey";
NSString * TableViewBuilderCellIdentifierKey = @"TableViewBuilderCellIdentifierkey";

NSString * CollectionViewBuilderCellClassKey = @"CollectionViewBuilderCellClassKey";
NSString * CollectionViewBuilderCellIdentifierKey = @"CollectionViewBuilderCellIdentifierKey";
NSString * CollectionViewBuilderCellSizeKey = @"CollectionViewBuilderCellSizeKey";

@implementation UIContainerBuilder

+ (UITableView *)tableViewWithBackgroundColor:(UIColor *)background rowHeight:(CGFloat)rowHeight cellInfo:(NSArray<NSDictionary *> *)cellClassesWithIdentifiers delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource {
    
    NSAssert(cellClassesWithIdentifiers != nil, @"cell info should not be nil");
    NSAssert(cellClassesWithIdentifiers.count > 0, @"cell info should contain something");
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = background ?: [UIColor whiteColor];
    tableView.rowHeight = rowHeight ?: 40;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    
    [cellClassesWithIdentifiers enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tableView registerClass:obj[TableViewBuilderCellClassKey] forCellReuseIdentifier:obj[TableViewBuilderCellIdentifierKey]];
    }];
    
    return tableView;
}

+ (UICollectionView *)collectionViewOfFlowLayout:(UICollectionViewLayout *)layout backgroundColor:(UIColor *)backgroundColor cellInfo:(NSArray<NSDictionary *> *)cellClassesWithIdentifiers delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource {
    NSAssert(layout != nil, @"there should be a layout");
    NSAssert(cellClassesWithIdentifiers != nil, @"cell info should not be nil");
    NSAssert(cellClassesWithIdentifiers.count > 0, @"cell info should contain something");
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = backgroundColor;
    collectionView.delegate = delegate;
    collectionView.dataSource = dataSource;
    
    [cellClassesWithIdentifiers enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [collectionView registerClass:obj[CollectionViewBuilderCellClassKey] forCellWithReuseIdentifier:obj[CollectionViewBuilderCellIdentifierKey]];
    }];
    
    return collectionView;
}

+ (UICollectionViewFlowLayout *)collectionFlowLayoutWithItemSize:(CGSize)itemSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    if (!CGSizeEqualToSize(itemSize, CGSizeZero)) flowLayout.itemSize = itemSize;
    flowLayout.scrollDirection = scrollDirection;
    
    return flowLayout;
}

@end
