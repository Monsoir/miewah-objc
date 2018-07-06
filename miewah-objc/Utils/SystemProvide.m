//
//  SystemProvide.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/7.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SystemProvide.h"

@implementation SystemProvide

+ (void)shareItems:(NSArray *)items {
    UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:aVC animated:YES completion:nil];
}

@end
