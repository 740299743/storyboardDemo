//
//  CustomTableViewCell.m
//  storyboardDemo
//
//  Created by pactera on 3/31/15.
//  Copyright (c) 2015 pactera. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
{
    UIView *snapView;
}

- (void)awakeFromNib
{
    _containerView.layer.cornerRadius = 4;
    
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    _shadowView.layer.shadowOpacity = 0.5;
    _shadowView.layer.shadowRadius = 5;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressGesture:)];
    
    [self.contentView addGestureRecognizer:longPress];
}

- (void)handleLongpressGesture:(UILongPressGestureRecognizer *)gesture
{
    CGPoint startPoint = CGPointZero;
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            snapView = [_containerView snapshotViewAfterScreenUpdates:NO];
            startPoint = [gesture locationInView:self.contentView];
            
            snapView.frame = _containerView.frame;
            snapView.transform = CGAffineTransformMakeRotation(M_PI/30);
            [self.contentView addSubview:snapView];
            self.contentView.hidden = YES;
            self.shadowView.hidden = YES;
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [gesture locationInView:self.contentView];
            snapView.center = changePoint;
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"ended");
            CGPoint endPoint = [gesture locationInView:self.contentView];
            if (endPoint.x > self.contentView.bounds.size.width - 50)
            {
                if (self.callBlock)
                {
                    self.callBlock(YES, _cellIndex);
                }
            }
            else
            {
                if (self.callBlock)
                {
                    self.callBlock(NO, _cellIndex);
                }
            }
            
            [snapView removeFromSuperview];
            self.contentView.hidden = NO;
            self.shadowView.hidden = NO;
            break;
        }
        
        default:
            break;
    }
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
