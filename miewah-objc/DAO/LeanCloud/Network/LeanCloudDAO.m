//
//  LeanCloudDAO.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LeanCloudDAO.h"
#import "LeanCloudCharacterDAO.h"
#import "LeanCloudWordDAO.h"
#import "LeanCloudSlangDAO.h"

@implementation LeanCloudDAO

+ (instancetype)requestManagerOfType:(MiewahItemType)type {
    switch (type) {
        case MiewahItemTypeCharacter:
            return [[LeanCloudCharacterDAO alloc] init];
        case MiewahItemTypeWord:
            return [[LeanCloudWordDAO alloc] init];
        case MiewahItemTypeSlang:
            return [[LeanCloudSlangDAO alloc] init];
            
        default:
            return nil;
    }
}

- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(LeanCloudListRequestSuccess)successHandler error:(LeanCloudRequestError)errorHandler {
    return nil;
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSString *)identifier success:(LeanCloudDetailRequestSuccess)successHandler error:(LeanCloudRequestError)errorHandler {
    return nil;
}

@end
