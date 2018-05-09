//
//  WordDetailViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahDetailViewModel.h"
#import "MiewahCharacter.h"

@interface CharacterDetailViewModel : MiewahDetailViewModel

@property (nonatomic, strong, readonly) MiewahCharacter *character;
@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

@end
