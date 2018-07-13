//
//  CollectionViewSimpleTextSectionAccessory.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/13.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewSimpleTextSectionAccessory;

@protocol CollectionViewSimpleTextSectionAccessoryDelegate

- (void)simpleTextSectionAccessoryDidSelect:(CollectionViewSimpleTextSectionAccessory *)accessory;

@end

@interface CollectionViewSimpleTextSectionAccessory : UICollectionReusableView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id<CollectionViewSimpleTextSectionAccessoryDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title;

+ (NSString *)reuseIdentifier;

@end
