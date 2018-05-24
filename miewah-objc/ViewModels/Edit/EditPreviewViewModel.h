//
//  EditPreviewViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "FoundationConstants.h"
#import "MiewahAssetRequestManager.h"

@interface EditPreviewViewModel : MiewahViewModel

@property (nonatomic, assign, readonly) MiewahItemType type;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *displayContents;

@property (nonatomic, strong, readonly) RACSubject *postSuccess;
@property (nonatomic, strong, readonly) RACSubject *postFailure;
@property (nonatomic, strong, readonly) RACSubject *postError;

- (BOOL)postData;

@end
