//
//  TableViewBuilder.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/11.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * TableViewBuilderCellClassKey;
extern NSString * TableViewBuilderCellIdentifierKey;

extern NSString * CollectionViewBuilderCellClassKey;
extern NSString * CollectionViewBuilderCellIdentifierKey;
extern NSString * CollectionViewBuilderCellSizeKey;

@interface UIContainerBuilder : NSObject


/**
 便利生成一个 UITableView

 @param background table view 的背景颜色
 @param rowHeight table view 的 cell 高度
 @param cellClassesWithIdentifiers table view 的 cell 的类及其对应的复用 id, 数组中的每个字典对应一个 cell
 @param delegate tableview view 的 delegate
 @param dataSource tableview view 的数据源
 @return UITableView
 */
+ (UITableView *)tableViewWithBackgroundColor:(UIColor *)background rowHeight:(CGFloat)rowHeight cellInfo:(NSArray<NSDictionary *> *)cellClassesWithIdentifiers delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource;


/**
 便利生成一个 UICollectionView

 @param layout collection view 布局方式
 @param backgroundColor collection view 的背景颜色
 @param cellClassesWithIdentifiers collection view 的 cell 的类及其对应的复用 id, 数组中的每个字典对应一个 cell
 @param delegate collection view 的 delegate
 @param dataSource collection view 的数据源
 @return UICollectionView
 */
+ (UICollectionView *)collectionViewOfFlowLayout:(UICollectionViewLayout *)layout backgroundColor:(UIColor *)backgroundColor cellInfo:(NSArray<NSDictionary *> *)cellClassesWithIdentifiers delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource;

/**
 生成一个 UICollectionViewFlowLayout

 @param itemSize cell 的固定大小，若不需要固定大小，则传 CGSizeZero
 @param scrollDirection collection view 的滚动方向
 @return UICollectionViewFlowLayout
 */
+ (UICollectionViewFlowLayout *)collectionFlowLayoutWithItemSize:(CGSize)itemSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@end
