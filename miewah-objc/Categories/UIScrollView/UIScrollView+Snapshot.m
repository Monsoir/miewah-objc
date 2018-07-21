//
//  UIScrollView+Snapshot.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "UIScrollView+Snapshot.h"

@implementation UIScrollView (Snapshot)

- (UIImage *)snapshot {
    // https://stackoverflow.com/a/28343200/5211544
    // https://stackoverflow.com/a/40923897/5211544
    
    UIImage *snapshot = nil;
    
//    UIGraphicsBeginImageContextwith(self.contentSize);
    UIGraphicsBeginImageContextWithOptions(self.contentSize, NO, 2.0); // better quality
    {
        CGPoint savedContentOffset = self.contentOffset;
        CGRect savedFrame = self.frame;
        
        self.contentOffset = CGPointZero;
        self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
        
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        snapshot = UIGraphicsGetImageFromCurrentImageContext();
        
        self.contentOffset = savedContentOffset;
        self.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
