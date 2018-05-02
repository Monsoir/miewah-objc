//
//  WordsViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "MiewahWord.h"

@interface WordsViewModel : MiewahViewModel

@property (nonatomic, strong, readonly) NSMutableArray<MiewahWord *> *words;

@property (nonatomic, strong, readonly) RACSignal *noMoreDataSignal;

@property (nonatomic, strong, readonly) RACSubject *loadedSuccess;
@property (nonatomic, strong, readonly) RACSubject *loadedFailure;
@property (nonatomic, strong, readonly) RACSubject *loadedError;

@end
