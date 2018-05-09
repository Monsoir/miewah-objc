//
//  SlangDetailViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahDetailViewModel.h"
#import "MiewahSlang.h"

@interface SlangDetailViewModel : MiewahDetailViewModel

@property (nonatomic, strong, readonly) MiewahSlang *slang;
@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

@end
