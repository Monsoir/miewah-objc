//
//  WordDetailViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahDetailViewModel.h"
#import "MiewahWord.h"

@interface WordDetailViewModel : MiewahDetailViewModel

@property (nonatomic, strong, readonly) MiewahWord *word;
@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

@end
