//
//  LocalAssetCollectionViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/11.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalAssetCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, copy) NSString *meaning;
@property (nonatomic, copy) NSString *updateAt;

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellHeight;
+ (CGFloat)cellWidth;
+ (CGSize)cellSize;

@end
