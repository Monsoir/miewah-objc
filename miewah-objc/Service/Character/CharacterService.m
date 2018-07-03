//
//  CharacterService.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterService.h"
#import "LeanCloudCharacterDAO.h"
#import "MiewahCharacter.h"

@interface CharacterService()

@property (nonatomic, strong) LeanCloudCharacterDAO *dao;

@end

@implementation CharacterService

- (void)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    [self getListFromLeanCloudAtPageIndex:pageIndex completion:completion];
}

- (void)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    [self getDetailFromLeanCloudOfIdentifier:identifier completion:completion];
}

- (void)getListFromLeanCloudAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    [self.dao getListAtPage:pageIndex success:^(NSArray *results) {
        NSMutableArray<MiewahCharacter *> *characters = [NSMutableArray array];
        [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:obj];
            [characters addObject:character];
        }];
        completion(characters, nil);
    } error:^(NSError *error) {
        completion(nil, error);
    }];
}

- (void)getDetailFromLeanCloudOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    [self.dao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
        MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:result];
        completion(character, nil);
    } error:^(NSError *error) {
        completion(nil, error);
    }];
}

- (LeanCloudDAO *)dao {
    if (_dao == nil) {
        _dao = [[LeanCloudCharacterDAO alloc] init];
    }
    return _dao;
}

@end
