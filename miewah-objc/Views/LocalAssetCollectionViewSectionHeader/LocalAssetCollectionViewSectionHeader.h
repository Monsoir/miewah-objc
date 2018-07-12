//
//  LocalAssetCollectionViewSectionHeader.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/12.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalAssetCollectionViewSectionHeader : UICollectionReusableView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *indicatorTitle;

+ (NSString *)reusableIdentifier;

@end

