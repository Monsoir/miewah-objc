//
//  ListLoadMoreFooterView.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ListLoadMoreFooterViewStatusLoading,
    ListLoadMoreFooterViewStatusNotLoading,
    ListLoadMoreFooterViewStatusNoMore,
} ListLoadMoreFooterViewStatus;

@class ListLoadMoreFooterView;

@protocol ListLoadMoreFooterViewDelegate
- (void)footerWillLoadMore:(ListLoadMoreFooterView *)footer;
@end

@interface ListLoadMoreFooterView : UIView

@property (nonatomic, assign) ListLoadMoreFooterViewStatus status;
@property (nonatomic, weak) id<ListLoadMoreFooterViewDelegate> delegate;

- (void)setTitle:(NSString *)title forStatus:(ListLoadMoreFooterViewStatus)status;

@end
