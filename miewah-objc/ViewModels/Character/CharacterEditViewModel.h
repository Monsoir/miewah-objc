//
//  CharacterEditViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"

@interface CharacterEditViewModel : MiewahViewModel

@property (nonatomic, copy) NSString *character;
@property (nonatomic, copy) NSString *pronunonciation;
@property (nonatomic, copy) NSString *meaning;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionName;
@property (nonatomic, strong, readonly) RACSignal *enableNextSignal;

@end
