//
//  EditExtraInfoViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "FoundationConstants.h"

@interface EditExtraInfoViewModel : MiewahViewModel

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sentences;
@property (nonatomic, copy) NSString *inputMethods;

@property (nonatomic, strong, readonly) RACSignal *sourceSignal;
@property (nonatomic, strong, readonly) RACSignal *sentencesSignal;
@property (nonatomic, strong, readonly) RACSignal *inputMethodsSignal;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;

- (instancetype)initWithType:(MiewahItemType)type;
- (void)readExtraInfos;

@end
