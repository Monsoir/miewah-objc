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

#pragma mark - Character

- (NSString *)charactersURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@%ld", MiewahBaseURL, MiewahCharactersURL, (long)pageIndex];
}

- (NSString *)characterDetailOfIdentifier:(NSNumber *)identifier {
    return [NSString stringWithFormat:@"%@%@%@", MiewahBaseURL, MiewahCharacterDetailURL, identifier];
}

- (NSString *)newCharacter {
    return [NSString stringWithFormat:@"%@%@", MiewahBaseURL, MiewahNewCharacterURL];
}

#pragma mark - Word

- (NSString *)wordsURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@%ld", MiewahBaseURL, MiewahWordsURL, (long)pageIndex];
}

- (NSString *)wordDetailOfIdentifier:(NSNumber *)identifier {
    return [NSString stringWithFormat:@"%@%@%@", MiewahBaseURL, MiewahWordDetailURL, identifier];
}

- (NSString *)newWord {
    return [NSString stringWithFormat:@"%@%@", MiewahBaseURL, MiewahNewWordURL];
}

#pragma mark - Slang

- (NSString *)slangsURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@%ld", MiewahBaseURL, MiewahSlangsURL, (long)pageIndex];
}

- (NSString *)slangDetailOfIdentifier:(NSNumber *)identifier {
    return [NSString stringWithFormat:@"%@%@%@", MiewahBaseURL, MiewahSlangDetailURL, identifier];
}

- (NSString *)newSlang {
    return [NSString stringWithFormat:@"%@%@", MiewahBaseURL, MiewahNewSlangURL];
}

@end
