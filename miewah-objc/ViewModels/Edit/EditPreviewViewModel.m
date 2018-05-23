//
//  EditPreviewViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditPreviewViewModel.h"
#import "NewMiewahAsset.h"

@interface EditPreviewViewModel()

@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) NSArray<NSString *> *displayContents;

@property (nonatomic, assign) MiewahItemType type;

@end

@implementation EditPreviewViewModel

- (instancetype)initWithAssetType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSArray<NSString *> *)displayContents {
    
    switch (self.type) {
        case MiewahItemTypeCharacter:
        {
            MiewahCharacter *temp = (MiewahCharacter *)[NewMiewahAsset sharedAsset].currentAsset;
            NSArray *result = @[
                                alwaysString(temp.meaning),
                                alwaysString(temp.source),
                                alwaysString(temp.sentences),
                                alwaysString(temp.inputMethods),
                                @"", // 查询关键字
                                ];
            return result;
        }
        case MiewahItemTypeWord:
        {
            MiewahWord *temp = (MiewahWord *)[NewMiewahAsset sharedAsset].currentAsset;
            NSArray *result = @[
                                alwaysString(temp.meaning),
                                alwaysString(temp.source),
                                alwaysString(temp.sentences),
                                @"",
                                @"",
                                ];
            return result;
        }
        case MiewahItemTypeSlang:
        {
            MiewahSlang *temp = (MiewahSlang *)[NewMiewahAsset sharedAsset].currentAsset;
            NSArray *result = @[
                                alwaysString(temp.meaning),
                                alwaysString(temp.source),
                                alwaysString(temp.sentences),
                                @"",
                                ];
            return result;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *fileName = nil;
        switch (self.type) {
            case MiewahItemTypeCharacter:
                fileName = @"WordDetailSections";
                break;
            case MiewahItemTypeWord:
                fileName = @"WordDetailSections";
                break;
            case MiewahItemTypeSlang:
                fileName = @"SlangDetailSections";
                break;
                
            default:
                break;
        }
        if (fileName == nil) return nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        _sectionNames = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionNames;
}

@end
