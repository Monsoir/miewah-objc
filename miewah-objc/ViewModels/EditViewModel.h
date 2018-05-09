//
//  EditViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/9.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"

@interface EditViewModel : MiewahViewModel

@property (nonatomic, strong) NSNumber *itemType;

@property (nonatomic, strong) RACSignal *ItemTypeSignal;

@end
