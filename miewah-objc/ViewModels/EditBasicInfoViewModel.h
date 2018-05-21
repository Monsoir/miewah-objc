//
//  EditBasicInfoViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "FoundationConstants.h"

@interface EditBasicInfoViewModel : MiewahViewModel

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *pronunonciation;
@property (nonatomic, copy) NSString *meaning;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) RACSignal *enableNextSignal;

- (instancetype)initWithType:(MiewahItemType)type;
- (void)readBasicInfos;

@end
