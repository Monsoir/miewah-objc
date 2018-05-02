//
//  MiewahAPIManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahAPIManager.h"
#import "APIAddresses.h"

@implementation MiewahAPIManager

+ (instancetype)sharedManager {
    static MiewahAPIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[MiewahAPIManager alloc] init];
    });
    return _sharedManager;
}

- (NSString *)registerURL {
    return [NSString stringWithFormat:@"%@%@", MiewahBaseURL, MiewahRegisterURL];
}

- (NSString *)loginURL {
    return [NSString stringWithFormat:@"%@%@", MiewahBaseURL, MiewahLoginURL];
}

- (NSString *)charactersURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@%ld", MiewahBaseURL, MiewahCharactersURL, (long)pageIndex];
}

- (NSString *)characterDetailOfIdentifier:(NSString *)identifier {
    return [NSString stringWithFormat:@"%@%@%@", MiewahBaseURL, MiewahCharacterDetailURL, identifier];
}

@end
