//
//  EditPreviewViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "FoundationConstants.h"

@interface EditPreviewViewModel : MiewahViewModel

@property (nonatomic, assign, readonly) MiewahItemType type;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

- (instancetype)initWithAssetType:(MiewahItemType)type;

@end
