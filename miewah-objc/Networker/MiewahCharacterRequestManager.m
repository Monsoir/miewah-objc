//
//  MiewahCharacterRequestManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahCharacterRequestManager.h"
#import "MiewahAPIManager.h"
#import "CharacterListResponseObject.h"

@implementation MiewahCharacterRequestManager

- (NSURLSessionDataTask *)getCharactersAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    MiewahNetworker *worker = [MiewahNetworker sharedNetworker];
    return [worker GET:[[MiewahAPIManager sharedManager] charactersURLWithPageIndex:pageIndex]
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   CharacterListResponseObject *payload = [[CharacterListResponseObject alloc] initWithDictionary:responseObject];
                   [payload.success boolValue] ? successHandler(payload) : failureHandler(payload);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   errorHandler(error);
               }];
}

@end
