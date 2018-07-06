//
//  ShareItemViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/6.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ShareItemViewController.h"
#import "ShareView.h"
#import "FoundationConstants.h"

@interface ShareItemViewController ()

@property (nonatomic, strong) ShareView *shareView;

@end

@implementation ShareItemViewController

- (instancetype)initWithShareInfo:(NSDictionary *)shareInfo {
    self = [super init];
    if (self) {
        NSDictionary *info = @{
                               ShareItemKey: [shareInfo valueForKey:AssetItemKey],
                               ShareMeaningKey: [shareInfo valueForKey:AssetMeaningKey],
                               ShareSentenceKey: [shareInfo valueForKey:AssetSentencesKey],
                               };
        _shareView = [[ShareView alloc] initWithUserInfo:info];
    }
    return self;
}

- (void)loadView {
    self.view = self.shareView;
    self.preferredContentSize = CGSizeMake(200, 300);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
