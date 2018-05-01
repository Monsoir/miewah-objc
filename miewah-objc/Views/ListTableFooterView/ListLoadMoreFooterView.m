//
//  ListLoadMoreFooterView.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "ListLoadMoreFooterView.h"
#import "UIView+Nib.h"

@interface ListLoadMoreFooterView ()

@property (nonatomic, weak) IBOutlet UIButton *btnLoad;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, copy) NSString *noMoreTitle;
@property (nonatomic, copy) NSString *notLoadingTitle;

@end

@implementation ListLoadMoreFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromNib];
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadViewFromNib];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self setTitle:@"加载更多" forStatus:ListLoadMoreFooterViewStatusNotLoading];
    [self setTitle:@"没有更多的数据了" forStatus:ListLoadMoreFooterViewStatusNoMore];
    [self.btnLoad setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.status = ListLoadMoreFooterViewStatusNotLoading;
    self.indicator.hidesWhenStopped = YES;
}

- (IBAction)actionLoadMore:(UIButton *)sender {
    if (self.status == ListLoadMoreFooterViewStatusNoMore) return;
    
    if (self.delegate) {
        [self.delegate footerWillLoadMore:self];
        self.status = ListLoadMoreFooterViewStatusLoading;
    }
}

- (void)setTitle:(NSString *)title forStatus:(ListLoadMoreFooterViewStatus)status {
    switch (status) {
        case ListLoadMoreFooterViewStatusNoMore:
            self.noMoreTitle = title;
            break;
        case ListLoadMoreFooterViewStatusNotLoading:
            self.notLoadingTitle = title;
            break;
            
        default:
            break;
    }
}

- (void)setStatus:(ListLoadMoreFooterViewStatus)status {
    _status = status;
    
    switch (status) {
        case ListLoadMoreFooterViewStatusLoading:
            {
                self.btnLoad.hidden = YES;
                self.btnLoad.enabled = YES;
                [self.btnLoad setTitle:@"" forState:UIControlStateNormal];
                self.indicator.hidden = NO;
                [self.indicator startAnimating];
            }
            break;
        case ListLoadMoreFooterViewStatusNotLoading:
            {
                self.btnLoad.hidden = NO;
                self.btnLoad.enabled = YES;
                [self.btnLoad setTitle:self.notLoadingTitle forState:UIControlStateNormal];
                [self.indicator stopAnimating];
            }
            break;
        case ListLoadMoreFooterViewStatusNoMore:
            {
                self.btnLoad.hidden = NO;
                self.btnLoad.enabled = NO;
                [self.btnLoad setTitle:self.noMoreTitle forState:UIControlStateNormal];
                [self.indicator stopAnimating];
            }
            break;
            
        default:
            break;
    }
}

@end
