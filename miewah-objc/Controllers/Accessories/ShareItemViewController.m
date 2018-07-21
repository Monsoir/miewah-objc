//
//  ShareItemViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "ShareItemViewController.h"
#import "ShareView.h"
#import "FoundationConstants.h"
#import "ViewShooter.h"

@interface ShareItemViewController ()

@property (nonatomic, strong) ShareView *shareView;
@property (nonatomic, strong) NSDictionary *shareInfo;

@end

@implementation ShareItemViewController

- (instancetype)initWithShareInfo:(NSDictionary *)shareInfo {
    self = [super init];
    if (self) {
        _shareInfo = shareInfo;
    }
    return self;
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ deallocs", [self class]);
#endif
}

- (void)loadView {
    self.view = self.shareView;
    self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, 300);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shootViewCompletion:(void (^)(UIImage *viewShot))completion {
    completion([self.shareView snapshot]);
}

- (ShareView *)shareView {
    if (_shareView == nil) {
        NSDictionary *info = @{
                               ShareItemKey: [self.shareInfo valueForKey:AssetItemKey],
                               ShareMeaningKey: [self.shareInfo valueForKey:AssetMeaningKey],
                               ShareSentenceKey: [self.shareInfo valueForKey:AssetSentencesKey],
                               };
        _shareView = [[ShareView alloc] initWithUserInfo:info];
    }
    return _shareView;
}

@end
