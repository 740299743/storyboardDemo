//
//  CustomTableViewCell.h
//  storyboardDemo
//
//  Created by pactera on 3/31/15.
//  Copyright (c) 2015 pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

typedef void (^handleGestureEndedBlock)(BOOL isDelete, NSIndexPath *index);

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIView *shadowView;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, copy) handleGestureEndedBlock callBlock;

@end
