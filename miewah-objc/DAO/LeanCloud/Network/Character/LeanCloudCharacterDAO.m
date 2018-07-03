//
//  LeanCloudCharacterListDAO.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LeanCloudCharacterDAO.h"
#import "LeanCloudAPIManager.h"

@implementation LeanCloudCharacterDAO

- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(LeanCloudListRequestSuccess)successHandler error:(LeanCloudRequestError)errorHandler {
    NSString *url = [SharedLeanCloudAPIManager characterListURLWithPageIndex:pageIndex];
    return [SharedLeanCloudGetter GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *results = [responseObject valueForKey:@"results"];
        successHandler(results);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorHandler(error);
    }];
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSString *)identifier success:(LeanCloudDetailRequestSuccess)successHandler error:(LeanCloudRequestError)errorHandler {
    NSString *url = [SharedLeanCloudAPIManager characterDetailOfIdentifier:identifier];
    return [SharedLeanCloudGetter GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorHandler(error);
    }];
}

@end
