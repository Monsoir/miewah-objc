//
//  UITableViewCell+ReuseIdentifier.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UITableViewCell+ReuseIdentifier.h"

@implementation UITableViewCell (ReuseIdentifier)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
