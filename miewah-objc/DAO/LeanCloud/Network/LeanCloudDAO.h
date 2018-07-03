//
//  LeanCloudDAO.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoundationConstants.h"
#import "LeanCloudGetter.h"

typedef void(^LeanCloudListRequestSuccess)(NSArray *results);
typedef void(^LeanCloudDetailRequestSuccess)(NSDictionary *result);

typedef void(^LeanCloudRequestFailure)(NSDictionary *errorInfo);
typedef void(^LeanCloudRequestError)(NSError *error);

@interface LeanCloudDAO : NSObject

+ (instancetype)requestManagerOfType:(MiewahItemType)type;

- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(LeanCloudListRequestSuccess)successHandler error:(LeanCloudRequestError)errorHandler;
- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSString *)identifier success:(LeanCloudDetailRequestSuccess)successHandler error:(LeanCloudRequestError)errorHandler;

@end
