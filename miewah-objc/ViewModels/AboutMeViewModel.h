//
//  AboutMeViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"

@interface AboutMeViewModel : MiewahViewModel

@property (nonatomic, strong, readonly) NSNumber *logged;
@property (nonatomic, strong, readonly) NSArray<NSString *> *interactiveItems;
@property (nonatomic, strong, readonly) RACSignal *loggedChangedSignal;

@end
