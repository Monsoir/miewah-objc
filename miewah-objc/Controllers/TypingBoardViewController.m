//
//  TypingBoardViewController.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "TypingBoardViewController.h"
#import "TextPlaceholderView.h"
#import "UIView+Layout.h"

#import "FoundationConstants.h"

@interface TypingBoardViewController ()

@property (nonatomic, strong) TextPlaceholderView *tpv;

@property (nonatomic, copy) NSString *inputPlaceholder;

@end

@implementation TypingBoardViewController

- (instancetype)initWithPlaceholder:(NSString *)placeholder {
    self = [super init];
    if (self) {
        _inputPlaceholder = placeholder;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupSubviews];
    [self setupNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [DefaultNotificationCenter removeObserver:self];
#if DEBUG
    NSLog(@"%@ deallocs", NSStringFromClass([self class]));
#endif
}

- (void)setupNavigationBar {
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionDismiss)];
    self.navigationItem.rightBarButtonItem = itemCancel;
    
    UIBarButtonItem *itemEndEditing = [[UIBarButtonItem alloc] initWithTitle:@"okk" style:UIBarButtonItemStylePlain target:self action:@selector(actionEndEditing)];
    self.navigationItem.leftBarButtonItem = itemEndEditing;
}

- (void)setupSubviews {
    self.view.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:self.tpv];
    
    NSArray<NSLayoutConstraint *> *constraints = [self.tpv fullLayoutConstraintsToParentView:self.view];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupNotifications {
    [DefaultNotificationCenter addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleKeyboardWillShow:(NSNotification *)notif {
    NSDictionary *userInfo = notif.userInfo;
    NSValue *animationDurationValue = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardFrameEndUserValue = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGRect keyboardRect;
    [keyboardFrameEndUserValue getValue:&keyboardRect];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGRect newViewRect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - keyboardHeight);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             self.view.frame = newViewRect;
                         }
                         completion:^(BOOL finished) {}];
    });
}

- (void)handleKeyboardWillHide:(NSNotification *)notif {
    NSDictionary *userInfo = notif.userInfo;
    NSValue *animationDurationValue = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardFrameEndUserValue = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGRect keyboardRect;
    [keyboardFrameEndUserValue getValue:&keyboardRect];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGRect newViewRect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height + keyboardHeight);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             self.view.frame = newViewRect;
                         }
                         completion:^(BOOL finished) {}];
    });
}

- (void)actionDismiss {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionEndEditing {
    [self.view endEditing:YES];
}

- (TextPlaceholderView *)tpv {
    if (_tpv == nil) {
        _tpv = [[TextPlaceholderView alloc] initWithPlaceholder:self.inputPlaceholder];
        _tpv.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tpv;
}

@end
