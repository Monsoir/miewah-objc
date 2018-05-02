//
//  WordDetailViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "MiewahCharacter.h"

@interface CharacterDetailViewModel : MiewahViewModel

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;
@property (nonatomic, strong, readonly) MiewahCharacter *characterDetail;

@property (nonatomic, strong, readonly) RACSubject *detailRequestSuccess;
@property (nonatomic, strong, readonly) RACSubject *detailRequestFailure;
@property (nonatomic, strong, readonly) RACSubject *detailRequestError;

- (void)loadWordDetail;
- (instancetype)initWithWordIdentifier:(NSString *)identifier;

@end
