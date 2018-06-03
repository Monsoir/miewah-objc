//
//  EditRecordTableViewCell.h
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+ReuseIdentifier.h"

typedef void(^PlayRecordBlock)(void);
typedef void(^DeleteRecordBlock)(void);

@interface EditRecordTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL hasContent;
@property (nonatomic, copy) PlayRecordBlock howToPlay;
@property (nonatomic, copy) DeleteRecordBlock howToDelete;

@end
