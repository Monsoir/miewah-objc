//
//  MiewahListViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "MiewahModel.h"

@interface MiewahListViewModel<T: MiewahModel*> : MiewahViewModel

@property (nonatomic, strong, readonly) NSMutableArray<T> *items;

@property (nonatomic, strong, readonly) RACSignal *noMoreDataSignal;

@property (nonatomic, strong, readonly) RACSubject *loadedSuccess;
@property (nonatomic, strong, readonly) RACSubject *loadedFailure;
@property (nonatomic, strong, readonly) RACSubject *loadedError;

- (void)loadData;
- (void)resetFlags;
- (void)reloadData;

@end
