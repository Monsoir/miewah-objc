//
//  LocalAssetListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/12.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LocalAssetListViewModel.h"
#import "DatabaseHelper.h"

@interface LocalAssetListViewModel()

@property (nonatomic, assign) MiewahItemType type;
@property (nonatomic, strong) RACSubject *readComplete;
@property (nonatomic, strong) NSMutableArray<MiewahAsset *> *items;

@end

@implementation LocalAssetListViewModel

- (instancetype)initWithAssetType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)fetchLocalAsset {
    [DatabaseHelper readFavoredItemsOfType:self.type skip:0 size:10 completion:^(NSArray<MiewahAsset *> *assets, NSString *errorMsg) {
#warning 请注意这里，可能会出现多线程的问题
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:assets];
        [self.readComplete sendNext:self.items];
    }];
}

- (NSString *)sectionTitle {
    switch (self.type) {
        case MiewahItemTypeCharacter:
            return @"字";
        case MiewahItemTypeWord:
            return @"词";
        case MiewahItemTypeSlang:
            return @"短语";
            
        default:
            return @"";
    }
}

#pragma mark - Accessors

- (RACSubject *)readComplete {
    if (_readComplete == nil) {
        _readComplete = [[RACSubject alloc] init];
    }
    return _readComplete;
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
